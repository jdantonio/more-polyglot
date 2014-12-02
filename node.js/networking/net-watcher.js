#!/usr/bin/env node --harmony

'use strict';

const
  fs = require('fs'),
  net = require('net'),
  filename = process.argv[2] || 'target.txt';

const server = net.createServer(function(connection) {

  // reporting
  console.log('Subscriber connected.');
  connection.write("Now watching '" + filename + "' for changes...\n");

  // watcher
  let watcher = fs.watch(filename, function() {
    connection.write("File '" + filename + "' changed at " + (new Date).toString() + "\n");
  });

  // cleanup
  connection.on('close', function() {
    console.log('Subscriber disconnected.');
    watcher.close();
  });
});

server.listen(5432, function() {
//server.listen('/tmp/watcher.sock', function() {
  console.log('Listening for subscribers...');
});
