
IEX::Api.configure do |config|
  config.publishable_token = Rails.application.credentials.config[:publishable_token]
  config.secret_token = Rails.application.credentials.config[:secret_token]
  config.endpoint = 'https://cloud.iexapis.com/v1' # use 'https://sandbox.iexapis.com/v1' for Sandbox
end

IEX_CLIENT = IEX::Api::Client.new