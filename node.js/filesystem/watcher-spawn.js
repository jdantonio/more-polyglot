#!/usr/bin/env node --harmony

"use strict";

const
  fs = require('fs'),
  spawn = require('child_process').spawn,
  filename = process.argv[2] || 'target.txt';

fs.watch(filename, function() {
  let ls = spawn('ls', ['-lh', filename]);
  ls.stdout.pipe(process.stdout);
});

console.log('Now watching ' + filename + ' for changes...');
