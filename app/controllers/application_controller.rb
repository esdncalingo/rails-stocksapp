class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  def initialize_iex_client
    @iex_client = IEX::Api::Client.new
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
