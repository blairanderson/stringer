# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application

if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    user = ENV['DJ_USER']
    raise "requires Delayed Job Username" unless user
    pw = ENV['DJ_PASSWORD']
    raise "requires Delayed Job Password" unless pw
    username == user && password == pw
  end
end