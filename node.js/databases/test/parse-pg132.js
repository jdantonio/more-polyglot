#!/usr/bin/env node --harmony

'use strict';

const rdfParser = require('../lib/rdf-parser.js');

rdfParser(__dirname + '/pg132.rdf', function(err, book) {
  console.log(book);
});
