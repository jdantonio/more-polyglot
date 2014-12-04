#!/usr/bin/env node --harmony

'use strict';

const request = require('request');
const argv = require('minimist')(process.argv.slice(2));

const options = {
  method: argv.m || argv.method || 'GET',
  url: 'http://localhost:5984/' + (argv.p || argv.path || '')
};

request(options, function(err, res, body) {
  if (err) {
    throw Error(err);
  } else {
    console.log(res.statusCode, JSON.parse(body));
  }
});
