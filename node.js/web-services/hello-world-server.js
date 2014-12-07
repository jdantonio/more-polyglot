#!/usr/bin/env node --harmony

'use strict';

const http = require('http');

const server = http.createServer(function(req, res) {
  res.writeHead(200, {'Content-type': 'text/plain'});
  res.end('Hello World!');
});

server.listen(3000, function() {
  console.log('Make it so!');
});
