class TransactionRepository 

  def self.show_balance(user_id)      
    user = User.find(user_id)
    user.balance 
  end

  def self.record_transaction(user_id, params)
    amount = params[:amount].gsub(/[^\d\.]/, '').to_f

    case params[:commit]
    when "Buy"
      qty = params[:qty]
    when "Sell"
      qty = params[:qty].to_f * -1
    end

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
      return true
    else 
      return new_transaction.errors_full_messages
    end
  end
  
end