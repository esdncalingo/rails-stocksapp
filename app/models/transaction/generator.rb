class Transaction
  class Generator
    def self.receipt(user_id,params)  
      # initialize variable area
      amount = params[:amount].gsub(/[^\d\.]/, '').to_f          
      user_balance = Transaction::Balance.compute(user_id) || 0 
      qty =  params[:qty]  || 0
      on_hand =  Transaction::Inventory.update(user_id,params[:symbol])      
      # initialize variable area

      # validation area     
      return "Amount cannot be less than zero" if amount < 0 
      return "Not enough balance" if ((amount > user_balance) && (params[:commit] == "Buy")  )
      return "Not enough on hand to sell" if ((qty.to_f > on_hand.to_f ) && (params[:commit] == "Sell") )
      return "No Stock was selected" if params[:symbol] == nil
      # validation area
      
      # business logic area
      if params[:commit] == 'Buy' || params[:commit] == 'Withdraw'  
        amount = amount > 0 ? amount * -1 : 0         
      end
      if params[:commit] == 'Sell'
        qty =  qty.to_f * -1
      end  
      # business logic area

      # recording transaction 
        new_transaction = Transaction.new(
          "user_id": user_id,
          "qty": qty ,
          "price": params[:price] ? params[:price] : 0,
          "amount": amount,
          "kind": params[:commit],
          "stock_code": params[:symbol],
          "crypto_code": params[:crypto_code],
        )

        if new_transaction.save
          puts user_balance
          user = User.find(user_id)          
          user.update(balance: user_balance + amount)
          return "OK"
        else 
          return new_transaction.errors_full_messages 
        end
    end
  end
end 


# def self.buy(user_id, params)
#   amount = params[:amount].gsub(/[^\d\.]/, '').to_f
  
#   if amount > 0
#     user = User.find(user_id)
#     user_balance = user.balance - amount
#     user.update(balance: user_balance)
#     TransactionRepository.record_transaction(user_id, params)
#   else
#     # --- error:  ---
#   end
# end

# def self.sell(user_id, params) 
#   amount = params[:amount].gsub(/[^\d\.]/, '').to_f
  
#   if amount > 0
#     user = User.find(user_id)
#     user_balance = user.balance + amount
#     user.update(balance: user_balance)
#     TransactionRepository.record_transaction(user_id, params)
#   else
#     # --- error:  ---
#   end
# end

# def self.deposit(user_id, amount)
#   amount = amount.gsub(/[^\d\.]/, '').to_f
  
#   if amount > 0
#     user = User.find(user_id)
#     user_balance = user.balance + amount
#     user.update(balance: user_balance)
#   else
#     # --- error: amount input is lessthan the requirements ---
#   end
# end
