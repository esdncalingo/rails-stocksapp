class StocksController < ApplicationController
  before_action :initialize_iex_client
  before_action :verify_stock_master
  

  def show
    # response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_ed7475c0c153436587bd10b8f1da9916')
    # top 10 list
    response = Faraday.get('https://cloud.iexapis.com/v1/stock/market/list/mostactive?token=pk_ed7475c0c153436587bd10b8f1da9916')
 
  #     conn = Faraday.new(:url => 'https://rest.coinapi.io') 

  #     # send request
  #     response = conn.get '/v1/assets/', params do |request|
  #       request.headers["X-CoinAPI-Key"] = '8CDEDC13-5ABA-45BD-95A6-3740729F2722'
  #     end


  @most_active_list = JSON.parse(response.body)
  selected_code = nil

  if !stocks_params['stock_code']    
    if @most_active_list.count == 0 
      selected_code = $stocks_master .first['symbol']
    else
      selected_code = @most_active_list.first['symbol']
    end
  else
    selected_code = stocks_params['stock_code']   
  end
    
    @chart_data = get_chart_data(selected_code)
    stock_details = get_stock_details(selected_code)
    @stock_name = stock_details["name"]
    @stock_price = stock_details["latest_price"]
    @stock_currency = stock_details["currency"]
    # @selected_stock = @client.company(selected_code).company_name
  
   
  end

  def purchase       
    # @stock_info = get_stock_details
  end

 

  private 

  def verify_stock_master
    redirect_to "/" if !$stocks_master 
  end

  def stocks_params
    params.permit(:stock_code, :stock_name, :authenticity_token)  
  end

  def get_chart_data(stock_symbol)

    pp   @client.chart('AACIU')
    # puts stock_symbol    
    chart = @client.chart(stock_symbol)
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

    stock_data =  $stocks_master.find { |s| s['name'] == stocks_params['stock_name']}
    
    client = @client.company(stock_symbol)
    logo = @client.logo(stock_symbol)
    quote = @client.quote(stock_symbol)
    income_statements = @client.income(stock_symbol)
    
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
