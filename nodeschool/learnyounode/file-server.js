#!/usr/bin/env node --harmony

var http = require('http'),
    fs = require('fs'),
    port = parseInt(process.argv[2]) || 3000,
    path = process.argv[3];

var server = http.createServer(function(request, response){
  var stream = fs.createReadStream(path);
  response.writeHead(200, { 'content-type': 'text/plain' })
  stream.pipe(response);
})

server.listen(port);
