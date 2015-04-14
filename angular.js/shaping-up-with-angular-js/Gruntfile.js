module.exports = function(grunt){

  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.config('concat', {
    scripts: {
      src: ['bower_components/jquery/dist/jquery.js',
            'bower_components/angular/angular.js',
            'products.js',
            'app.js'],
      dest: 'tmp/app.js'
    },
    styles: {
      src: ['bower_components/bootstrap/dist/css/bootstrap.css',
            'application.css'],
      dest: 'tmp/app.css'
    }
  });

  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.config('uglify', {
    options: {
      mangle: true,
      compress: true
    },
    scripts: {
      files: {
        'assets/app.js' : 'tmp/app.js'
      }
    }
  });
 
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.config('cssmin', {
    app: {
      files: {
        'assets/app.css': ['tmp/app.css']
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.config('copy', {
    scripts: {
      files: [
          {expand: true, cwd: 'tmp', src: 'app.js', dest: 'assets'}
      ]
    },
    styles: {
      files: [
          {expand: true, cwd: 'tmp', src: 'app.css', dest: 'assets'}
      ]
    }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.config('watch', {
    scripts: {
      files: ['./**/*.js'],
      tasks: ['build:scripts'],
	  
      options: {
        spawn: false
      }
    },
    styles: {
      files: ['./**/*.css'],
      tasks: ['build:styles'],
      options: {
        spawn: false
      }
    },
    //interface: {
      //files: ['index.html']
    //},
    //options: {
      //livereload: true
    //}
  }); 

  grunt.loadNpmTasks('grunt-shell');
  grunt.config('shell', {
    serve: {
      command: function() {
        return 'http-server';
      }
    }
  });

  grunt.registerTask('build:scripts', "Builds the javascript.",
                    ['concat:scripts', 'copy:scripts']);
                    //['concat:scripts', 'uglify']);

  grunt.registerTask('build:styles', "Builds the stylesheets.",
                    ['concat:styles', 'copy:styles']);
                    //['concat:styles', 'cssmin']);

  grunt.registerTask('build', "Builds the application.",
                    ['build:scripts', 'build:styles']);

  grunt.registerTask('serve', 'Build then run in a web server', ['build', 'shell:serve']);

  grunt.registerTask('default', 'Builds the application', ['build']);
}
