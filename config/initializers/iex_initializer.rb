
IEX::Api.configure do |config|
  config.publishable_token = Rails.application.credentials.config[:publishable_token]
  config.secret_token = Rails.application.credentials.config[:secret_token]
  config.endpoint = 'https://cloud.iexapis.com/v1' # use 'https://sandbox.iexapis.com/v1' for Sandbox
end

# @iex_client = IEX::Api::Client.new(
#   publishable_token: Rails.application.credentials.config[:publishable_token],
#   secret_token: Rails.application.credentials.config[:secret_token],
#   #endpoint: 'https://cloud.iexapis.com/v1'
# )

# def initialize_iex_client
  # @iex_client = IEX::Api::Client.new
# end