class Transaction
  class Balance
    def self.get_updated_balance(user_id)      
      user_balance = Transaction.where("user_id" == user_id).sum(&:amount)    
      user_balance = 0 if !user_balance 
      return user_balance 
    end
  end
end 
