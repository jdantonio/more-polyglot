#!/usr/bin/env node --harmony

var fs = require('fs'),
    path = require('path'),
    directory,
    extension;

directory = process.argv[2];
extension = '.' + process.argv[3];

fs.readdir(directory, function(err, list){
  if (err) {
    console.log(err);
  } else {

    list = list.filter(function(file){
      return path.extname(file) == extension;
    });

    list.forEach(function(file){
      console.log(file);
    });
  }
})
