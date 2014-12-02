#!/usr/bin/env node --harmony

'use strict';

// npm install minimist
const argv = require('minimist')(process.argv.slice(2));

const
  fs = require('fs'),
  zmq = require('zmq');

const filename = argv.f || argv.file || 'target.txt';

// publisher endpoint
const publisher = zmq.socket('pub');

fs.watch(filename, function() {
  publisher.send(JSON.stringify({
    type: 'changed',
    file: filename,
    timestamp: Date.now()
  }));
});

// listen on TCP port 5432
publisher.bind('tcp://*:5432', function(err) {
  console.log('Listening for zmq subscribers...');
});
