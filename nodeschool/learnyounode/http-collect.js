#!/usr/bin/env node --harmony

var http = require('http'),
    url = process.argv[2],
    buffer = '';

http.get(url, function(response){
  response.setEncoding('utf8');

  response.on('data', function(data){
    buffer += data
  });

  response.on('end', function(){
    console.log(buffer.length);
    console.log(buffer);
  });

  response.on('error', function(err){
    console.error(err);
  });
});
