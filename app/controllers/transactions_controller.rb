class TransactionsController < ApplicationController
  
  def record
    valid_transaction = true
    authentication = Authentication.find_by("token": session[:gen_token])    
    #update for the latest stock price
    latest_price = StocksRepository.stock_details(transaction_params['stock_code'])['latest_price']

    #get user latest balance      
    # user_balance = wallet
    user_balance = Transaction::Balance.get_updated_balance(authentication['user_id'])
    on_hand =  Transaction::Inventory.update(Authentication.find_by("token": session[:gen_token])['user_id'],  transaction_params['stock_code'])

    #implement computations
    valid_transaction = true
    transaction_qty  = transaction_params['qty'] == "" ? 0 :  transaction_params['qty']
    transaction_amount = latest_price.to_f * transaction_qty.to_f   
    transaction_kind = params[:commit]
    
    #verify kind of transaction
    if transaction_kind == 'Withdraw' || transaction_kind == 'Deposit'
      transaction_amount = transaction_params['tAmount']
    end
    if transaction_kind == 'Buy' || transaction_kind == 'Withdraw'               
      if transaction_amount > user_balance #condition for balance validation
        valid_transaction = false
      end
      transaction_amount = transaction_amount > 0 ? transaction_amount * -1 : transaction_amount   
    elsif transaction_kind == 'Sell' || transaction_kind == 'Deposit'
      if transaction_kind == 'Sell' && transaction_qty > on_hand
        valid_transaction = false
      end
      transaction_qty = transaction_qty.to_i > 0 ? transaction_qty.to_i * -1 : transaction_qty.to_i              
    end

    # record transaction
    if valid_transaction #condition for balance validation
        @new_transaction = TransactionRepository.record_transaction(
          authentication['user_id'],
          transaction_qty,
          latest_price,
          transaction_amount,
          transaction_kind,
          transaction_params['stock_code'],
          ""
        ) 
        if @new_transaction
          head :ok   
        end
    else  #condition for balance validation
      format.html { render json: { not_found: true }, status: 403 } #condition for balance validation
    end #condition for balance validation
  end

  private

  def transaction_params
    params.permit(:user_id, :stock_code, :stock_name, :qty, :commit, :tAmount, :authenticity_token)  
  end
end