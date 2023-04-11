class HomeController < ApplicationController
  #before_action :authenticate_user
  before_action :require_user
  before_action :initialize_iex_client
  before_action :is_admin

  def index
    #store in global variable stocks masterlist
    response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_ed7475c0c153436587bd10b8f1da9916') 
    $stocks_master = JSON.parse(response.body)   
    # $stocks_master = response
    # $stocks_master = JSON.parse(response.body)   
    $stocks_master = response
    
    userauth = Authentication.find_by(token: session[:gen_token])
    pending = userauth.user.status === "pending" ? true : false

    if pending 
      redirect_to pending_page_path
    end
  end

  def pending
  end

  def sample 
  end

end