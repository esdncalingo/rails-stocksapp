class StocksRepository
  # before_action :initialize_iex_client
  @iex_client = IEX::Api::Client.new
  def self.stock_details(stock_symbol)
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
    
    stock_details
  end

  private
end
