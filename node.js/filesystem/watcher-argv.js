#!/usr/bin/env node --harmony

const fs = require('fs');
const filename = process.argv[2];

//NOTE: `const` will accept multiple assignments 
//const
//  fs = require('fs'),
//  filename = process.argv[2];

if (!filename) {
  throw Error("A file to watch must be specified!");
}

fs.watch(filename, function() {
  console.log("File " + filename + " just changed!");
});

console.log("Now watching " + filename + " for changes...");
