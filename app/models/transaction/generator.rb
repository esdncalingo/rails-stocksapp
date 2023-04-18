class Transaction
  class Generator
    def self.do(user_id)      
      user_balance = Transaction.where("user_id" == user_id).sum(&:amount)    
      user_balance = 0 if !user_balance 
      return user_balance 
    end
  end
end 
