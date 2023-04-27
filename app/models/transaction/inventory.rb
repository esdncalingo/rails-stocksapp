class Transaction
  class Inventory
    def self.stock_count(user_id,stock_code)
      stock_count = Transaction.where("user_id = ? AND stock_code = ?", user_id, stock_code).sum(&:qty)        
      stock_count 
    end
  end
end 
