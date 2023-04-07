class StocksController < ApplicationController
  before_action :initialize_iex_client

  def show
    company = @client.company('MSFT')

    @selected_company = company.company_name

    # response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_ed7475c0c153436587bd10b8f1da9916')

    # top 10 list
    response = Faraday.get('https://cloud.iexapis.com/v1/stock/market/list/mostactive?token=pk_ed7475c0c153436587bd10b8f1da9916')
 
  #     conn = Faraday.new(:url => 'https://rest.coinapi.io') 

  #     # send request
  #     response = conn.get '/v1/assets/', params do |request|
  #       request.headers["X-CoinAPI-Key"] = '8CDEDC13-5ABA-45BD-95A6-3740729F2722'
  #     end



    puts response.body.kind_of?(Array)
    puts response.body.kind_of?(String)

    data = JSON.parse(response.body)
   
   @master_list = data  #.filter { |item| item['symbol'] == "AMZN"}

    pp $stocks_master

    end
end
