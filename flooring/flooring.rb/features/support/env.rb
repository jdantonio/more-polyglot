$:.push File.dirname(__FILE__)

require 'aruba/cucumber'
require 'rspec/expectations'
require 'factory_girl'

FactoryGirl.definition_file_paths = %w(factories)
FactoryGirl.find_definitions

World(FactoryGirl::Syntax::Methods)

# import all the support files
Dir[File.join(File.dirname(__FILE__), '../../spec/support/**/*.rb')].each do |f|
  require File.expand_path(f)
end
