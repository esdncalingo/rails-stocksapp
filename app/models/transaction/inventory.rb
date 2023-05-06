class Transaction
  class Inventory
    def self.stock_count(user_id,stock_code)
      # stock_count= Transaction.includes(:user).where("user.id = ? AND transaction.stock_code = ?", user_id, stock_code)
      # stock_count = Transaction.where("user_id = ? AND stock_code = ?", user_id, stock_code).sum(&:qty)        
      user = User.find(user_id)
      stock_count = user.transactions.where("user_id = ? AND stock_code = ?", user_id, stock_code).sum(&:qty)
      stock_count 
    end
  end
end 
