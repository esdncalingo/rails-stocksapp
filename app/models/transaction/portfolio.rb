class Transaction
  class Portfolio
    def self.display(user_id)  
      stocks_transactions =  my_transactions(user_id)
      my_portfolios = stocks_transactions.map { |transaction|
        stock_details(user_id, transaction["stock_code"])
        # stock_details(transaction["user_id"], transaction["stock_code"])
      }
      my_portfolios   
    end

    private
    def self.my_transactions(user_id)
      user = User.find(user_id)
      user.transactions.distinct.select("stock_code").where.not(stock_code: nil)
    end

    def self.stock_details(user_id, stock_symbol)
     
      stock_portfolio = {
        "logo" => "",
        "code" => "",
        "name" => "",
        "qty" => 0,
        "latest_price" => 0.00,
        "change_percent" => ""
      }  
      # details = StocksRepository.stock_details(stock_symbol)
      details = Stock::Profile.details(stock_symbol)
      # pp details
      stock_portfolio["logo"] = details["logo"]
      stock_portfolio["code"] =  details["code"]
      stock_portfolio["name"] =  details["name"]    
      stock_portfolio["qty"] = stock_inventory(user_id, stock_symbol)        
      stock_portfolio["latest_price"] =  details["latest_price"]   
      stock_portfolio["change_percent"] =  details["change_percent"]
      
      stock_portfolio
    end

    def self.stock_inventory(user_id, stock_symbol)
      Transaction::Inventory.update(user_id, stock_symbol)
    end
  end
end 
