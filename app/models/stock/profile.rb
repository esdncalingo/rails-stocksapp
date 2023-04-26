class Stock   
  class Profile
    IEX_CLIENT = IEX::Api::Client.new
    def self.details(stock_symbol)
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
      
      client = IEX_CLIENT.company(stock_symbol)
      logo = IEX_CLIENT.logo(stock_symbol)
      quote = IEX_CLIENT.quote(stock_symbol)
      income_statements = IEX_CLIENT.income(stock_symbol)
      
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
end
