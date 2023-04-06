class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  def initialize_iex_client
    @client = IEX::Api::Client.new(
      publishable_token: 'pk_ed7475c0c153436587bd10b8f1da9916',
      secret_token: 'sk_5b436cad7697420cb38608baba594b33',
    )
  end
  
  def current_user
    token = session[:gen_token]
    is_active = session[:user_active]

    if token.present?
      user ||= Authentication.find_by(token: token)
    end
  end

  def is_active
  end

  def require_user
    redirect_to "/signin" unless current_user
  end

end
