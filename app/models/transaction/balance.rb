class Transaction
  class Balance
    def self.show(user_id)       
      # user_balance = Transaction.where("user_id" == user_id).sum(&:amount)    
      # user_balance = 0 if !user_balance 

      # my_account = User.find_by("user_id" == user_id)
      # my_account['balance'] = user_balance
      user = User.find(user_id)
      user.balance 
      # user_balance 
    end
    def self.compute
      user_balance = Transaction.where("user_id" == user_id).sum(&:amount)    
      user_balance = 0 if !user_balance
    end
  end
end 
