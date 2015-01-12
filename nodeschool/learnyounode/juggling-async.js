#!/usr/bin/env node --harmony

var http = require('http'),
    urls = process.argv.slice(2),
    buffers = [],
    done = 0;

urls.forEach(function(url, index){
  buffers[index] = '';

  http.get(url, function(response){
    response.setEncoding('utf8');

    response.on('data', function(data){
      buffers[index] += data
    });

    response.on('end', function(){
      done++;
      if (done == urls.length) {
        buffers.forEach(function(buffer){
          console.log(buffer);
        });
      }
    });
  });
});
