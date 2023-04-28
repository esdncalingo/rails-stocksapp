class Transaction
  class Balance
    
    def self.compute(user_id)         
      user_balance = Transaction.where("user_id" == user_id).sum(&:amount)          
    end
   
  end
end 
