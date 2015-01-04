var subreddit_display_width = 3;
var topics_to_display = 4;

var SUBREDDIT = (function (width) {

  var base_url = 'http://www.reddit.com/';
  var count = 0;
  var after = null;

  var buildQS = function (options) {
    var data = $.extend({
      after: after,
      count: count,
      limit: 25
    }, options);

    var qs = '?';

    for (var key in data) {
      qs += key + '=' + data[key] + '&'
    }

    return qs;
  };

  var hotTopicsDeferred = function (subreddit, limit) {
    limit = limit || topics_to_display
    var promise = $.Deferred();

    $.getJSON(base_url + '/r/' + subreddit + '/hot.json?limit=' + limit , function(response){
      var topics = $.map(response.data.children, function(child){
        return {
          subreddit: subreddit,
          title: child.data.title,
          url: child.data.url
        };
      });
      promise.resolve(topics);
    });

    return promise;
  };

  return {

    asyncPopularSubreddits: function (limit) {
      var self = this;
      var qs = buildQS({limit: width});

      $.getJSON(base_url + 'subreddits/popular.json' + qs, function(response) {

        after = response.data.after
        count += response.data.children.length;

        // for all subreddits, make AJAX calls for the topics
        var subreddits = $.map(response.data.children, function(child) {
          var subreddit = child.data.display_name;
          return {
            subreddit: subreddit,
            topics: hotTopicsDeferred(subreddit)
          };
        });

        // retrieve the deferreds from the subreddits collection
        var topics = $.map(subreddits, function(subreddits) {
          return subreddits.topics;
        });

        // wait for all hot topic requests to complete
        $.when.apply(null, topics).done(function(){
          console.log(arguments);
          limit -= width
          if (limit > 0) {
            self.asyncPopularSubreddits(limit);
          }
        });
      });
    }
  };
})(subreddit_display_width);
