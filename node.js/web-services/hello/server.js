#!/usr/bin/env node --harmony

'use strict';

const
  express = require('express'), // web framework
  morgan = require('morgan'),   // logger
  app = express();

app.use(morgan('dev'));

app.get('/api/:name', function(req, res) {
  res.status(200).json({'hello': req.params.name})
});

app.listen(3000, function() {
  console.log('Make it so!');
});
