ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'shoulda/matchers'
require 'webmock/rspec'
require 'coveralls'
Coveralls.wear!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

module Features
  # Extend this module in spec/support/features/*.rb
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Devise::TestHelpers, type: :controller
  config.include Features, type: :feature
  config.include UsersSpecHelper, type: :feature
  config.include Formulaic::Dsl, type: :feature

  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.use_transactional_fixtures = false
end

ActiveRecord::Migration.maintain_test_schema!
Capybara.javascript_driver = :webkit
WebMock.disable_net_connect!(allow_localhost: true)


def by(message)
  if block_given?
    yield
  else
    pending message
  end
end

alias and_by by