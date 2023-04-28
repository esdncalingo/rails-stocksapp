class Transaction
  class Generator
    def self.receipt(user_id,params)  
      # initialize variable area
      amount = params[:amount].gsub(/[^\d\.]/, '').to_f          
      user_balance = Transaction::Balance.compute(user_id) || 0 
      qty =  params[:qty].to_i  || 0
      on_hand =  Transaction::Inventory.stock_count(user_id,params[:symbol])      
      # initialize variable area
      
      # business logic area
      case params[:commit]
      when "Deposit"
        return "Amount cannot be less than one" if amount < 1
      when "Buy" || "Withdraw"
        return "Not enough balance" if (amount > user_balance)
        return "Amount cannot be less than the price" if (amount < params[:price].to_f)
        amount = amount > 0 ? amount * -1 : 0  
      when "Sell"
        return "Not enough on hand to sell" if (qty.to_f > on_hand.to_f )
        return "Quantity cannot be less than zero" if (qty.to_f < 1)
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
          user = User.find(user_id)          
          user.update(balance: user_balance + amount)
          return "OK"
        else 
          return new_transaction.errors_full_messages 
        end
    end
  end
end 
