require 'simplecov'

SimpleCov.start do
  project_name 'flooring.rb'
  add_filter '/coverage/'
  add_filter '/factories/'
  add_filter '/features/'
  add_filter '/pkg/'
  add_filter '/spec/'
  add_filter '/yardoc/'
end

require 'factory_girl'
require 'flooring'

FactoryGirl.definition_file_paths = %w(factories)
FactoryGirl.find_definitions

# import all the support files
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each do |f|
  require File.expand_path(f)
end

RSpec.configure do |config|
  config.order = 'random'
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
  end

  config.after(:each) do
  end
end
