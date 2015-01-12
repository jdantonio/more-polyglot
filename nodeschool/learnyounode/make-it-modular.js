#!/usr/bin/env node --harmony

var filter = require('./directory-filter.js'),
    directory = process.argv[2],
    extension = process.argv[3];

filter(directory, extension, function(err, list){
  if (err) {
    console.log(err);
  } else {
    list.forEach(function(file){
      console.log(file);
    });
  }
})
