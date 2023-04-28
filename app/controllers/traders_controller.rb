class TradersController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :require_user
  before_action :initialize_stocks_master
  before_action :company_dashboard, only: [:buysell]

  def index
    @most_active = Stock::Marketlist.mostactive
    @news = Stock::Marketlist.latest_news

    userauth = Authentication.find_by(token: session[:gen_token])
    pending = userauth.user.status === "pending" ? true : false

    if pending 
      redirect_to pending_page_path
    end
  end

  def pending; end

  def buysell
    @paginated_items = Kaminari.paginate_array($stocks_master).page(params[:page]).per(10)
  end

  def market
    @mostactive = Stock::Marketlist.mostactive
    @gainers = Stock::Marketlist.gainers
    @losers = Stock::Marketlist.losers
  end

  def profile 
    @user_details = User.find(current_user.id)
    @latest_login = @user_details.logins.last
    @auth_lvl = @user_details.authentication
    @portfolio= Transaction::Portfolio.display(current_user.id)
  end

  def transaction
    @user_history = Transaction::History.show(current_user.id, params[:kind])    
  end

  def filter_transaction
    @user_history = Transaction::History.show(current_user.id, params[:kind])
    respond_to do |format|
      format.turbo_stream{
        render turbo_stream: turbo_stream.update("transaction_history", partial: "traders/user/transaction", locals:{
          user_history: @user_history
        })
      }
    end    
  end

  # ------ balance transactions ------

  def add_balance
    transaction_result = Transaction::Generator.receipt(current_user.id, params)
    if transaction_result == "OK"
      head :ok, { msg: "Transaction Complete" }
    else
      head :not_acceptable, { msg: transaction_result }
    end
  end

  def user_buysell
    
    transaction_result = Transaction::Generator.receipt(current_user.id, params)
    if transaction_result == "OK"
      user = User.find(current_user.id)   
      symbol = params[:symbol] ||= 'TSLA'
      onhand = Transaction::Inventory.stock_count(current_user.id, symbol)
      
      respond_to do |format|
        format.turbo_stream { render turbo_stream: [
            turbo_stream.update("balance", number_to_currency(user.balance)),
            turbo_stream.update("onhand", onhand)
          ]}
      end
    else
      head :not_acceptable, { msg: transaction_result }
    end
    
  end

  private
#-----------------------------
  def company_dashboard
    symbol = params[:symbol] ||= 'TSLA'
    @quote = IEX_CLIENT.quote(symbol)
    @logo = IEX_CLIENT.logo(symbol)['url']
    @chart_data = Stock::Chart.candle(symbol)
    @balance = Transaction::Balance.compute(current_user.id)
    @onhand = Transaction::Inventory.stock_count(current_user.id, symbol)
  end
  
end