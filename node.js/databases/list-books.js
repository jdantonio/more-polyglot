#!/usr/bin/env node --harmony

'use strict';

const
  file = require('file'),
  rdfParser = require('./lib/rdf-parser.js');

console.log('beginning directory walk...');

file.walk(__dirname + '/cache', function(err, dirPath, dirs, files) {
  files.forEach(function(path) {
    rdfParser(path, function(err, doc) {
      if (err) {
        throw err;
      } else {
        console.log(doc);
      }
    });
  });
});

// Will raise an exception when file descriptors are exhausted...
//
// $ ./list-books.js
// beginning directory walk...
// 
// /Users/Jerry/Projects/more-polyglot/node.js/databases/list-books.js:15
//         throw err;
//               ^
// Error: EMFILE, open '/Users/Jerry/Projects/more-polyglot/node.js/databases/cache/epub/12290/pg12290.rdf'
