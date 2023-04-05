class ApplicationController < ActionController::Base

  def initialize_iex_client
    @client = IEX::Api::Client.new(
      publishable_token: 'pk_ed7475c0c153436587bd10b8f1da9916',
      secret_token: 'sk_5b436cad7697420cb38608baba594b33',
    )
  end
end
