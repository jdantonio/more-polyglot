module.exports = function (directory, ext, callback) {

  var fs = require('fs'),
      path = require('path'),
      extension = '.' + ext;

  fs.readdir(directory, function(err, list){
    if (err) {
      return callback(err);
    } else {

      list = list.filter(function(file){
        return path.extname(file) == extension;
      });

      return callback(null, list);
    }
  })
}
