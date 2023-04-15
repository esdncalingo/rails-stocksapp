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

    if token.present?
      user = Authentication.find_by(token: token)
      user.user
    end
  end

  def require_user
    token = session[:gen_token]
    
    if token.present?
      user ||= Authentication.find_by(token: token)
    end    
    redirect_to "/signin" unless user
  end

  def require_admin
    admin ||= session[:is_admin]
    redirect_to "/admin" unless admin
  end

end
