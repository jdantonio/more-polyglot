module.exports = function(grunt){

  grunt.config.init({
    hello: {
      options: {
        greeting: 'Hello from Grunt.',
      }
    }
  });
  
  grunt.registerTask('hello', 'Hello World!', function(){
    this.requiresConfig(this.name + '.options.greeting');
    var greeting = this.options().greeting;
    grunt.log.writeln(greeting);
  });

  grunt.registerTask('default', 'Run all tasks', ['hello']);
}
