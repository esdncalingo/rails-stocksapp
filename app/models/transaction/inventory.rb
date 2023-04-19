class Transaction
  class Inventory
    def self.update(user_id,stock_code)      
      puts user_id
      puts stock_code
      stock_count = Transaction.where("user_id = ? AND stock_code = ?", user_id, stock_code).sum(&:qty)        
      return stock_count 
    end
  end
end 
