#!/usr/bin/env node --harmony

'use strict';

// npm install minimist
const argv = require('minimist')(process.argv.slice(2));

const zmq = require('zmq');
const message_count = parseInt(argv.n || argv.num || '3');
const filename = argv.f || argv.file || 'target.txt';

// create request endpoint
const requester = zmq.socket('req');

// handle replies from responder
requester.on('message', function(data) {
  let response = JSON.parse(data);
  console.log('Received response:', response);
});

requester.connect('tcp://localhost:5433');

// send request for content
for (let i = 1; i <= message_count; i++) {
  console.log('Sending request ' + i + ' for ' + filename);
  requester.send(JSON.stringify({
    path: filename
  }));
}
