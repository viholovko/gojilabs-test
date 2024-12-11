ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'spec_helper'
require 'shoulda/matchers'

abort("The Rails environment is running in production mode!") if Rails.env.production?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end


RSpec.configure do |config|
  config.before(:suite) do
    # DatabaseCleaner.strategy = :transaction
    # DatabaseCleaner.clean_with(:truncation)
    FactoryBot.reload
  end

  # config.before(:each) do
  #   DatabaseCleaner.start
  # end

  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end
  
  config.include FactoryBot::Syntax::Methods
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end