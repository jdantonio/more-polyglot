#!/usr/bin/env node --harmony

'use strict';

const net = require('net');

const server = net.createServer(function(connection) {
  console.log('Subscriber connected.');

  // send the first message chunk
  connection.write('{"type":"changed","file":"targ');

  // delay 1 sec then send another chunk
  let timer = setTimeout(function() {
    connection.write('et.txt","timestamp":1358175758495}' + "\n");
    connection.end();
  }, 1000);

  // clear timer
  connection.on('end', function() {
    clearTimeout(timer);
    console.log('Subscriber disconnected');
  });
});

server.listen(5432, function() {
  console.log('Test server listening for subscribers...');
});
