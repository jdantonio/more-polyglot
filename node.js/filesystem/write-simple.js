#!/usr/bin/env node --harmony

const
  fs = require('fs');
  txt = process.argv[2] || 'Node.js the Right Way: Practical, Server-Side JavaScript That Scales';

fs.writeFile('target.txt', txt, function(err) {
  if (err) throw err;
  console.log('File saved!');
});
