class HomeController < ApplicationController
  #before_action :authenticate_user
  before_action :require_user
  before_action :initialize_iex_client

  def index
    #store in global variable stocks masterlist
    response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_ed7475c0c153436587bd10b8f1da9916') 
    # $stocks_master = JSON.parse(response.body)   
    $stocks_master = response
  end

  def sample 
  end

end