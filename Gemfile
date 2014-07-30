source 'https://rubygems.org'

ruby '2.1.2'

gem 'airbrake'
gem 'bootstrap-sass', git: 'https://github.com/blairanderson/bootstrap-sass.git'
gem 'chosen-rails'
gem 'coffee-rails'
gem 'compass-rails'
gem 'delayed_job_active_record'
gem 'devise'
gem 'email_validator'
gem 'feedbag', '~> 0.9.2'
gem 'feedjira', '~> 1.3.0'
gem 'flutie'
gem 'font-awesome-rails', git: 'https://github.com/blairanderson/font-awesome-rails'
gem 'haml-rails'
gem 'high_voltage'
gem 'jquery-rails'
gem 'momentjs-rails'
gem 'neat', '~> 1.5.1'
gem 'paloma'
gem 'pg'
gem 'rack-timeout'
gem 'rails', '4.1.1'
gem 'recipient_interceptor'
gem 'sass-rails', '~> 4.0.3'
gem 'simple_form'
gem 'simple_enum'
gem 'title'
gem 'twitter-text'
gem 'uglifier'
gem 'unicorn'

group :development do
  gem 'foreman'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'coveralls', require: false
  gem 'awesome_print'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 2.14.0'
end

group :test do
  gem 'capybara-webkit', '>= 1.0.0'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm', '>= 3.7.3'
end
