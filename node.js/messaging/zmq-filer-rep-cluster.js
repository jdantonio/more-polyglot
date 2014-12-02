#!/usr/bin/env node --harmony

'use strict';

const
  cluster = require('cluster'),
  fs = require('fs'),
  zmq = require('zmq');

if (cluster.isMaster) {

  // create router and dealer
  let router = zmq.socket('router').bind('tcp://127.0.0.1:5433');
  let dealer = zmq.socket('dealer').bind('ipc://filer-dealer.ipc');

  // forward between router and dealer
  router.on('message', function() {
    console.log('Message received by router.');
    let frames = Array.prototype.slice.call(arguments);
    dealer.send(frames);
  });

  dealer.on('message', function() {
    console.log('Message received by dealer.');
    let frames = Array.prototype.slice.call(arguments);
    router.send(frames);
  });

  // listen for workers to join the cluster
  cluster.on('online', function(worker) {
    console.log('Worker ' + worker.process.pid + ' is online.');
  });

  // fork 3 workers
  for (let i = 0; i < 3; i++) {
    cluster.fork();
  }

} else {

  // connect responder to dealer
  let responder = zmq.socket('rep').connect('ipc://filer-dealer.ipc');

  responder.on('message', function(data) {
    
    // parse message
    let request = JSON.parse(data);
    console.log(process.pid + ' received request for: ' + request.path);

    // read file and respond
    fs.readFile(request.path, function(err, data) {
      console.log(process.pid + ' sending response...');
      responder.send(JSON.stringify({
        pid: process.id,
        data: data.toString(),
        timestamp: Date.now()
      }));
    });
  });
}
