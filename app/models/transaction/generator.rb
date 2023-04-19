class Transaction
  class Generator
    def self.do(user_id)      
      user_balance = Transaction.where("user_id" == user_id).sum(&:amount)    
      user_balance = 0 if !user_balance 
      return user_balance 
    end

    def self.buy(user_id, params)
      amount = params[:amount].gsub(/[^\d\.]/, '').to_f
      
      if amount > 0
        user = User.find(user_id)
        user_balance = user.balance - amount
        user.update(balance: user_balance)
        TransactionRepository.record_transaction(user_id, params)
      else
        # --- error:  ---
      end
    end
  
    def self.sell(user_id, params) 
      amount = params[:amount].gsub(/[^\d\.]/, '').to_f
      
      if amount > 0
        user = User.find(user_id)
        user_balance = user.balance + amount
        user.update(balance: user_balance)
        TransactionRepository.record_transaction(user_id, params)
      else
        # --- error:  ---
      end
    end
  
    def self.deposit(user_id, amount)
      amount = amount.gsub(/[^\d\.]/, '').to_f
      
      if amount > 0
        user = User.find(user_id)
        user_balance = user.balance + amount
        user.update(balance: user_balance)
      else
        # --- error: amount input is lessthan the requirements ---
      end
    end
  end
end 
