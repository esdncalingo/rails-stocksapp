class TransactionRepository 

  def self.get_updated_balance(user_id)      
    user = User.find(user_id)
    user.balance 
  end

  def self.record_transaction(user_id, params)
    amount = params[:amount].gsub(/[^\d\.]/, '').to_f

    new_transaction = Transaction.new(
      "user_id": user_id,
      "qty": params[:qty] ? params[:qty] : 0 ,
      "price": params[:price] ? params[:price] : 0,
      "amount": amount,
      "kind": params[:commit],
      "stock_code": params[:stock_code],
      "crypto_code": params[:crypto_code],
    )

    if new_transaction.save
      return true
    else 
      return new_transaction.errors_full_messages
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