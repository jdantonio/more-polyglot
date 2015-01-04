// http://www.reddit.com/dev/api
// 
// listings
// 
// Many endpoints on reddit use the same protocol for controlling pagination and filtering.
// These endpoints are called Listings and share five common parameters: after / before,
// limit, count, and show.
// 
// Listings do not use page numbers because their content changes so frequently. Instead,
// they allow you to view slices of the underlying data. Listing JSON responses contain after
// and before fields which are equivalent to the "next" and "prev" buttons on the site and in
// combination with count can be used to page through the listing.
// 
// The common parameters are as follows:
// 
// after / before - only one should be specified. these indicate the fullname of an item in the
//                  listing to use as the anchor point of the slice.
// limit - the maximum number of items to return in this slice of the listing.
// count - the number of items already seen in this listing. on the html site, the builder uses
//         this to determine when to give values for before and after in the response.
// show - optional parameter; if all is passed, filters such as "hide links that I have voted on"
//        will be disabled.
// To page through a listing, start by fetching the first page without specifying values for after
// and count. The response will contain an after value which you can pass in the next request. It
// is a good idea, but not required, to send an updated value for count which should be the number
// of items already fetched.

var SUBREDDIT = (function(){

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
      if (data[key] !== undefined) {
        qs += key + '=' + data[key] + '&'
      }
    }

    console.log(qs);
    return qs;
  };

  var hotTopicsDeferred = function (subreddit, limit) {
    var qs = buildQS({limit: limit});
    var promise = $.Deferred();

    $.getJSON(base_url + '/r/' + subreddit + '/hot.json' + qs , function(response){
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
      var qs = buildQS({limit: limit});

      $.getJSON(base_url + 'subreddits/popular.json' + qs, function(response) {

        after = response.data.after
        count += response.data.children.length;

        console.log('after: ' + after);
        console.log('count: ' + count);

        var subreddits = $.map(response.data.children, function(child) {
          var subreddit = child.data.display_name;
          return {
            subreddit: subreddit,
            topics: hotTopicsDeferred(subreddit, 4)
          };
        });

        $.when.apply(null, subreddits).done(function(){
          for (var i = 0; i < arguments.length; i++) {
            console.log(arguments[i]);
          }
          console.log('all done');
          if (count < 9) {
            self.asyncPopularSubreddits(3);
          }
        });
      });
    }
  };
})();
