# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'flooring/version'

Gem::Specification.new do |spec|
  spec.name          = 'flooring'
  spec.version       = Flooring::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Jerry D'Antonio"]
  spec.email         = ['stumpjumper@gmail.com']
  spec.homepage      = 'http://www.jerrydantonio.com'
  spec.license       = 'MIT'

  spec.summary       = %q{Flooring orders for SWC Corp.}
  spec.date          = Time.now.strftime('%Y-%m-%d')

  spec.description = <<-EOF
    The goal of this mastery project is to create an application that allows for reading and writing flooring orders for SWC Corp.
  EOF

  spec.files            = Dir['{lib,bin}/**/*']
  spec.bindir           = 'bin'
  spec.executables      = %w(flooring)
  spec.extra_rdoc_files = Dir['README*', 'LICENSE*', 'CHANGELOG*']
  spec.require_paths    = ['lib']

  spec.required_ruby_version = '>= 2.0.0'
end
