var subreddit_display_width = 3;
var topics_to_display = 4;
var subreddit_container = $('.subreddit-main')

var SUBREDDIT = (function (display_width) {

  var base_url = 'http://www.reddit.com';
  var count = 0;
  var after = null;

  function Subreddit(data) {
    this.description = data.description;
    this.display_name = data.display_name;
    this.header_title = data.header_title;
    this.id = data.id;
    this.name = data.name;
    this.title = data.title;
    this.url = data.url;
  };

  var renderSubreddit = function(subreddit, topics) {
    var div_width = 12 / display_width;
    var box = $('<div>');
    var title = $('<h2>');
    var list = $('<ul>');
    var subreddit_p = $('<p>');
    var subreddit_a = $('<a>');

    box.addClass('col-md-' + div_width);
    title.text(subreddit.display_name);
    box.append(title);

    $.each(topics, function(index, topic) {
      var li = $('<li>')
      var topic_a = $('<a>');
      topic_a.attr('href', topic.url);
      topic_a.text(topic.title).succinct({size: 40});
      li.append(topic_a);
      list.append(li);
    });
    box.append(list);

    subreddit_a.addClass('btn');
    subreddit_a.addClass('btn-default');
    subreddit_a.attr('href', base_url + subreddit.url);
    subreddit_a.text('Visit ' + subreddit.display_name + " >>");
    subreddit_p.append(subreddit_a);
    box.append(subreddit_p);

    return box;
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

    popularSubreddits: function (limit, container) {
      var self = this;
      container = container || subreddit_container;

      var qs = $.param({
        after: after,
        count: count,
        limit: display_width
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
          var row = $('<div>');
          row.addClass('row');

          $.each(arguments, function(index, item){
            var div = renderSubreddit(subreddits[index], item);
            row.append(div);
          });

          container.append(row);

          limit -= display_width
          if (limit > 0) {
            self.popularSubreddits(limit, container);
          }
        });
      });
    }
  };
})(subreddit_display_width);
