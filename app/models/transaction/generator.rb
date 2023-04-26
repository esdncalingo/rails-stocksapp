class Transaction
  class Generator
    def self.process(user_id)   # commit, price, qty, amount   => params
      # user_balance = Transaction.where("user_id" == user_id).sum(&:amount)    
      # user_balance = 0 if !user_balance 

      user_balance = Transaction::balance.compute(user_id)
      #implement computations
      valid_transaction = true
      # transaction_qty  = transaction_params['qty'] == "" ? 0 :  transaction_params['qty']
      # transaction_amount = latest_price.to_f * transaction_qty.to_f   
      # transaction_kind = params[:commit]
    
      #verify kind of transaction
      if transaction_kind == 'Withdraw' || transaction_kind == 'Deposit'
        transaction_amount = transaction_params['tAmount']
      end
      if transaction_kind == 'Buy' || transaction_kind == 'Withdraw'               
        if params["amount"]> user_balance #condition for balance validation
          valid_transaction = false
        end
        transaction_amount = transaction_amount > 0 ? transaction_amount * -1 : transaction_amount   
      elsif transaction_kind == 'Sell' || transaction_kind == 'Deposit'
        if transaction_kind == 'Sell' && transaction_qty > on_hand
          valid_transaction = false
        end
        transaction_qty = transaction_qty.to_i > 0 ? transaction_qty.to_i * -1 : transaction_qty.to_i              
      end
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
