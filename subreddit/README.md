# Build an alternative Reddit interface

We're designing an alternative interface for Reddit. If you're not familiar with Reddit, here's what you need to know:

* Reddit is a social news / link sharing site (it calls itself "the front page of the Internet"). Users submitlinks, which can either be links to other sites they find interesting or relevant to the audience, or long-form posts they write on the site themselves.
* Users upvote and downvote those links -- how popular (or hot) a link is determines how many people will see it.
* Reddit is organized into subreddits: each subreddit is a small community that focuses on a theme (like movies, science, minecraft, or bitcoin). Links are submitted to a specific subreddit, and each community has different tastes and opinions on what content that community finds interesting.
* Any link can be commented on by Reddit users.
* Reddit also has a phenomenal JSON API (http://reddit.com/dev/api) that is well-thought out and comprehensive. We'll be using that API to build our interface.

## Here's what you need to build:

* An alternative Reddit interface that (in its most basic form) lists the set of popular subreddits, and allows users to see popular (or hot) links for each subreddit. You don't need to implement voting or other mechanics for this interface.
* This interface should be built in pure HTML / CSS / JavaScript using the Reddit API, as a front-end only application. This means there should be no back-end code, solely front-end JavaScript code for the application itself.
* You can use whatever tools, libraries, or frameworks you like to build this.
* Here's the specific API endpoints you'll need to use for this exercise:
  * /subreddits/popular.json: http://www.reddit.com/dev/api#GET_subreddits_{where}
  * /r/[subreddit]/hot.json: http://www.reddit.com/dev/api#GET_hot

## Copyright

Copyright &copy; 2013 [Jerry D'Antonio](https://twitter.com/jerrydantonio).
It is free software and may be redistributed under the terms specified in
the LICENSE file.

## License

Released under the MIT license.

http://www.opensource.org/licenses/mit-license.php  

> Permission is hereby granted, free of charge, to any person obtaining a copy  
> of this software and associated documentation files (the "Software"), to deal  
> in the Software without restriction, including without limitation the rights  
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
> copies of the Software, and to permit persons to whom the Software is  
> furnished to do so, subject to the following conditions:  
> 
> The above copyright notice and this permission notice shall be included in  
> all copies or substantial portions of the Software.  
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN  
> THE SOFTWARE.  
