# Backbone Tutorials

Backbone.js tutorials from the [backbonetutorials.com](http://backbonetutorials.com/) web site and [Leanpub book](https://leanpub.com/backbonetutorials).

## Resources

* [Backbone Tutorials (web)](http://backbonetutorials.com/)
* [Backbone Tutorials (Leanpub)](https://leanpub.com/backbonetutorials)
* [What is a view? (jsFiddle)](http://jsfiddle.net/tBS4X/1/)
* [Chapter 1 complete (jsFiddle)](http://jsfiddle.net/thomas/C9wew/4/)
* [Chapter 1 semi-complete (jsFiddle)](http://jsfiddle.net/thomas/dKK9Y/6/)
* [User Management tutorial (eheyne)](https://github.com/eheyne/user-management)
* [Fresco Bakery tutorial (skingdev)](https://github.com/skingdev/fresco-bakery)
* [Todo list using RethinkDB, Flask, and Backbone.js](http://www.rethinkdb.com/docs/examples/flask-backbone-todo/)

## Usage

### Node.js without a database

To test our application we will use a Node.js module called [http-server](https://www.npmjs.org/package/http-server) to bring up a local webserver and host our page.  To install this locally use this command:

```shell
  npm install -g http-server
```

or if you are on a Mac and get an `EACCES` error.

```shell
  sudo npm install -g http-server
```

Now in the `workspace` folder where you changed the code, run the command:

```shell
http-server
```

Now bring up a browser and navigate to `localhost:8080`.  You should see the application appear in the browser window.  Going forward this mechanism can be used in each of the project step folders to bring up the application.

### Ruby with a mock in-memory database

To test our application we will use a Ruby module called [Sinatra](http://www.sinatrarb.com) to bring up a local webserver and host our page. To install this locally use this commands:

```shell
gem install bundler
bundle install
```

Now in the `workspace` folder where you changed the code, run the command:

```shell
ruby app.rb
```

Now bring up a browser and navigate to `http://localhost:8080`. You should see the application appear in the browser window. Going forward this mechanism can be used in each of the project step folders to bring up the application.

## Copyright

Copyright &copy; 2014 [Jerry D'Antonio](https://twitter.com/jerrydantonio).
It is free software and may be redistributed under the terms specified in the LICENSE.

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
