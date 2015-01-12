#!/usr/bin/env node --harmony

var fs = require('fs'),
    filename,
    buffer,
    count = 0;

filename = process.argv[2];
buffer = fs.readFileSync(filename).toString();
count = buffer.split("\n").length - 1;

console.log(count);
