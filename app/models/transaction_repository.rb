class TransactionRepository 
  def self.get_updated_balance(user_id)      
    user_balance = Transaction.where("user_id" == user_id).sum(&:amount)    
    user_balance = 0 if !user_balance 
    return user_balance 
  end

  def self.record_transaction(user_id, qty, price, amount, kind, stock_code, crypto_code)
    new_transaction = Transaction.new(
      "user_id": user_id,
      "qty": qty,
      "price": price,
      "amount": amount,
      "kind": kind,
      "stock_code": stock_code,
      "crypto_code": crypto_code,
    )

    if new_transaction.save
      return true
    else 
      return new_transaction.errors_full_messages
    end

  end
end