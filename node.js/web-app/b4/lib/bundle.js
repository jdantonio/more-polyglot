'use strict';

const
  Q = require('q'),
  request = require('request');

module.exports = function(config, app) {
  
  app.post('/api/bundle', function(req, res) {
    
    let deferred = Q.defer();  
    
    request.post({
      url: config.b4db,
      json: { type: 'bundle', name: req.query.name, books: {} }
    }, function(err, couchRes, body) {
      if (err) {
        deferred.reject(err);  
      } else {
        deferred.resolve([couchRes, body]);  
      }
    });
    
    deferred.promise.then(function(args) {  
      let couchRes = args[0], body = args[1];
      res.json(couchRes.statusCode, body);
    }, function(err) {  
      res.json(502, { error: 'bad_gateway', reason: err.code });
    });
    
  });
  
  app.get('/api/bundle/:id', function(req, res) {  
    Q.nfcall(request.get, config.b4db + '/' + req.params.id)  
      .then(function(args) {
        let couchRes = args[0], bundle = JSON.parse(args[1]);
        res.json(couchRes.statusCode, bundle);
      }, function(err) {
        res.json(502, { error: 'bad_gateway', reason: err.code });
      });
  });
  
  app.put('/api/bundle/:id/name/:name', function(req, res) {
    Q.nfcall(request.get, config.b4db + '/' + req.params.id)
      .then(function(args) {  
        let couchRes = args[0], bundle = JSON.parse(args[1]);
        
        if (couchRes.statusCode !== 200) {
          return [couchRes, bundle];  
        }
        
        bundle.name = req.params.name;
        return Q.nfcall(request.put, {  
          url: config.b4db + '/' + req.params.id,
          json: bundle
        });
        
      })
      .then(function(args) {  
        let couchRes = args[0], body = args[1];
        res.json(couchRes.statusCode, body);
      })
      .catch(function(err) {  
        res.json(502, { error: 'bad_gateway', reason: err.code });
      });
  });
};
