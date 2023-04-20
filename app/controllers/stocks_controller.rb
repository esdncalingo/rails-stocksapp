class StocksController < ApplicationController
  before_action :initialize_iex_client
  #before_action :verify_stock_master
  

  def show
    response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_ed7475c0c153436587bd10b8f1da9916')
    $stocks_master = JSON.parse(response.body)
    # $stocks_master = response
    # top 10 list
    response = Faraday.get('https://cloud.iexapis.com/v1/stock/market/list/mostactive?token=pk_ed7475c0c153436587bd10b8f1da9916')
    logo = @iex_client.logo("TSLA")
  #     conn = Faraday.new(:url => 'https://rest.coinapi.io') 

  #     # send request
  #     response = conn.get '/v1/assets/', params do |request|
  #       request.headers["X-CoinAPI-Key"] = '8CDEDC13-5ABA-45BD-95A6-3740729F2722'
  #     end


  $most_active_list = JSON.parse(response.body)
  # @user_balance = TransactionRepository.get_updated_balance(Authentication.find_by("token": session[:gen_token])['user_id']  )
  @user_balance = Transaction::Balance.get_updated_balance(Authentication.find_by("token": session[:gen_token])['user_id']  )
  @on_hand =  Transaction::Inventory.update(Authentication.find_by("token": session[:gen_token])['user_id'],  stocks_params['stock_code'])


  if stocks_params['stock_code']    
    selected_code = stocks_params['stock_code'] 
  else
    selected_code = default_selected
  end
    
    @chart_data = get_chart_data(selected_code)
    @stock_details = get_stock_details(selected_code)
    @stock_name = @stock_details["name"]
    @stock_price = @stock_details["latest_price"]
    @stock_currency = @stock_details["currency"]    
  end

  def profile
   
    if !stocks_params['stock_code']
      stock_code = default_selected
    else
      stock_code = stocks_params['stock_code'] 
    end
    @stock_info = StocksRepository.stock_details(stock_code)
    @on_hand =  Transaction::Inventory.update(Authentication.find_by("token": session[:gen_token])['user_id'],  stocks_params['stock_code'])
    @portfolio= Transaction::Portfolio.display(Authentication.find_by("token": session[:gen_token])['user_id'])
    # print @portfolio
    # @stock_info = Stocks::Profile.details(stock_code)
  end


 
  private 

  def verify_stock_master
    redirect_to "/" if !$stocks_master 
  end

  def default_selected
    if $most_active_list.count == 0 
      selected_code = $stocks_master .first['symbol']
    else
      selected_code = $most_active_list.first['symbol']
    end
  end

  def stocks_params
    params.permit(:stock_code, :stock_name, :qty, :commit, :authenticity_token)  
  end

  def get_chart_data(stock_symbol)
    # puts stock_symbol    
    chart = @iex_client.chart(stock_symbol)
    chart_arr = chart.reduce([]) { |init, curr| 
      init.push([curr['label'], curr['open'], curr['close'], curr['high'], curr['low']]);     
    }.inject({}) do |res, k|
        res[k[0]] = k[1..-1]
        res
      end
  
  end

  def get_stock_details(stock_symbol)
    # return nil if !stocks_params['stock_name']
    stock_details = {
      code: "",
      name: "",
      ceo: "",
      currency: "",
      industry: "",      
      exchange: "",
      description: "",
      logo: "",
      latest_price: "",
      change_percent: ""
    }
    response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_06f0670b09884fe5aa66d394e4263f00')
    $stocks_master = JSON.parse(response.body)
    stock_data =  $stocks_master.find { |s| s['name'] == stocks_params['stock_name']}
    
    client = @iex_client.company(stock_symbol)
    logo = @iex_client.logo(stock_symbol)
    quote = @iex_client.quote(stock_symbol)
    income_statements = @iex_client.income(stock_symbol)
    
    stock_details["code"] = client.symbol
    stock_details["name"] = client.company_name 
    stock_details["ceo"] = client.ceo     
    stock_details["industry"] = client.industry    
    stock_details["exchange"] = client.exchange
    stock_details["description"] = client.description 
    stock_details["logo"] = logo.url
    stock_details["latest_price"] = quote.latest_price # 90.165    
    stock_details["change_percent"] = quote.change_percent_s # '+0.42%'  
    
    return stock_details
  end  
  
end
