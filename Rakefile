# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
if ['development', 'test'].include? ENV['RAILS_ENV']
  require 'ci/reporter/rake/rspec'
end

NicoMarketArchive::Application.load_tasks
