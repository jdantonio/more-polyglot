#!/usr/bin/env node --harmony

var net = require('net'),
    port = parseInt(process.argv[2]) || 3000;

function zeroFill(i) {
  return (i < 10 ? '0' : '') + i
}

function now() {
  var date = new Date(),
      str = '';

  str += date.getFullYear();
  str += '-';
  str += zeroFill(date.getMonth() + 1);
  str += '-';
  str += zeroFill(date.getDate());
  str += ' ';
  str += zeroFill(date.getHours());
  str += ':';
  str += zeroFill(date.getMinutes());

  return str;
}

var server = net.createServer(function(socket){
  socket.end(now());
})

server.listen(port);
