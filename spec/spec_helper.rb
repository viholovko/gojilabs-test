require 'simplecov'
require 'ffaker'

SimpleCov.start :rails do
  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Services', 'app/services'

  add_filter 'app/models/application_record.rb'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/controllers/application_controller.rb'
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/channels/application_cable/connection.rb'
  add_filter 'app/controllers/api/v1/payments_controller.rb'
  add_filter 'app/mailers/application_mailer.rb'
  add_filter '/app/mailers/'
  add_filter '/lib/'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
