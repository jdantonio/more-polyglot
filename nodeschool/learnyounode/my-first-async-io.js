#!/usr/bin/env node --harmony

var fs = require('fs'),
    filename,
    buffer,
    count = 0;

filename = process.argv[2];

fs.readFile(filename, function(err, data){
  if (err) {
    console.log(err);
  } else {
    buffer = data.toString();
    count = buffer.split("\n").length - 1;
    console.log(count);
  }
})
