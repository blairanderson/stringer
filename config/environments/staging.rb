require_relative 'production'

Mail.register_interceptor(
  RecipientInterceptor.new(ENV.fetch('EMAIL_RECIPIENTS'))
)

Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'herokuapp.com' }

  config.app_domain = 'herokuapp.com'

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { host: config.app_domain }
  config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      port: '587',
      enable_starttls_auto: true,
      user_name: ENV["gmail_email"],
      password: ENV["gmail_password"],
      authentication: :plain,
      domain: config.app_domain
  }
end
