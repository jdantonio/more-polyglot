#!/usr/bin/env node --harmony

var http = require('http'),
    map = require('through2-map'),
    port = parseInt(process.argv[2]) || 3000;

var server = http.createServer(function(request, response){
  if (request.method == 'POST') {
    request.pipe(map(function(chunk){
      return chunk.toString().toUpperCase();
    })).pipe(response);
  } else {
    console.log(request.method);
    return response.end();
  }
})

server.listen(port);
