#!/usr/bin/env node --harmony

var offset = 2, 
    argc = process.argv.length,
    sum = 0;

for (var i = offset; i < argc; i++) {
  sum += parseInt(process.argv[i]);
}

console.log(sum);
