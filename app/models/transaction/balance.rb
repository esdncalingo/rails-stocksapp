class Transaction
  class Balance
    def self.show(user_id)           
      user = User.find(user_id)
      user.balance       
    end
    def self.compute(user_id)         
      user_balance = Transaction.where("user_id" == user_id).sum(&:amount)          
    end
   
  end
end 
