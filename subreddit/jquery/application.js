var subreddit_display_width = 3;
var subreddit_topics_to_display = 4;
var subreddit_container = $('.subreddit-main')
var subreddit_template = $('#subreddit-template')

var SUBREDDIT = (function() {

  var base_url = 'http://www.reddit.com';
  var count = 0;
  var after = null;

  var template = Handlebars.compile(subreddit_template.html());

  function Subreddit(data) {
    this.description = data.description;
    this.display_name = data.display_name;
    this.header_title = data.header_title;
    this.id = data.id;
    this.name = data.name;
    this.title = data.title;
    this.url = data.url;
  };

  var hotTopicsDeferred = function (subreddit, limit) {
    limit = limit || subreddit_topics_to_display
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

    popularSubreddits: function (limit, callback) {
      var self = this;

      var qs = $.param({
        after: after,
        count: count,
        limit: subreddit_display_width
      });

      $.getJSON(base_url + '/subreddits/popular.json?' + qs, function(response) {

        after = response.data.after
        count += response.data.children.length;

        // for all subreddits, make AJAX calls for the topics
        var topics = [];
        var subreddits = $.map(response.data.children, function(child) {
          topics.push(hotTopicsDeferred(child.data.display_name));
          return new Subreddit(child.data);
        });

        // wait for all hot topic requests to complete
        $.when.apply(null, topics).done(function(){

          var data = $.map(arguments, function(item, index){
            return {
              div_width: 12 / subreddit_display_width,
              subreddit: subreddits[index],
              topics: item
            };
          });

          // process the template
          var row = template({
            subreddits: data
          });
          subreddit_container.append(row);

          // recurse or finish
          limit -= subreddit_display_width
          if (limit > 0) {
            self.popularSubreddits(limit, callback);
          } else if (callback) {
            callback();
          }
        });
      });
    }
  };
})();
