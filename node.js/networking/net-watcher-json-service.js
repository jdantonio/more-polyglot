#!/usr/bin/env node --harmony

'use strict';

const
  fs = require('fs'),
  net = require('net'),
  filename = process.argv[2] || 'target.txt';

const server = net.createServer(function(connection) {

  // reporting
  console.log('Subscriber connected.');
  connection.write(JSON.stringify({
    type: 'watching',
    file: filename
  }) + '\n');

  // watcher
  let watcher = fs.watch(filename, function() {
    connection.write(JSON.stringify({
      type: 'changed',
      file: filename,
      timestamp: Date.now()
    }) + '\n');
  });

  // cleanup
  connection.on('close', function() {
    console.log('Subscriber disconnected.');
    watcher.close();
  });
});

server.listen(5432, function() {
  console.log('Listening for subscribers...');
});
