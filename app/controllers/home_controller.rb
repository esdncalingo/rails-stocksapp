class HomeController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :require_user
  before_action :initialize_iex_client
  before_action :initialize_stocks_master
  before_action :company_dashboard

  helper_method :get_logo

  def index
    # URL: https://cloud.iexapis.com/v1
    #store in global variable stocks masterlist
    response = Faraday.get('https://cloud.iexapis.com/v1/stock/market/list/mostactive?token=pk_06f0670b09884fe5aa66d394e4263f00') 
    @most_active = JSON.parse(response.body)   

    response = Faraday.get('https://cloud.iexapis.com/v1/stock/market/batch?types=news&range=1m&last=5&token=pk_06f0670b09884fe5aa66d394e4263f00')
    @news = JSON.parse(response.body)

    userauth = Authentication.find_by(token: session[:gen_token])
    pending = userauth.user.status === "pending" ? true : false

    if pending 
      redirect_to pending_page_path
    end
  end

  def pending
  end

  def buysell
    @chart_data = get_chart_data('AAPL')
    @paginated_items = Kaminari.paginate_array($stocks_master).page(1).per(10)
  end

  def market
    #response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_06f0670b09884fe5aa66d394e4263f00')
    #@stocks_master = JSON.parse(response.body)

    @testingmarket = @iex_client.company('TSLA')

    response = Faraday.get('https://cloud.iexapis.com/v1//stock/market/list/mostactive?token=pk_06f0670b09884fe5aa66d394e4263f00&listLimit=5')
    @mostactive = JSON.parse(response.body)

    response = Faraday.get('https://cloud.iexapis.com/v1//stock/market/list/gainers?token=pk_06f0670b09884fe5aa66d394e4263f00&listLimit=5')
    @gainers = JSON.parse(response.body)

    response = Faraday.get('https://cloud.iexapis.com/v1//stock/market/list/losers?token=pk_06f0670b09884fe5aa66d394e4263f00&listLimit=5')
    @losers = JSON.parse(response.body)

  end

  def trade
  end

  # ------ balance transactions ------

  def add_balance
    Transaction::Generator.deposit(current_user.id, params[:amount])
    TransactionRepository.record_transaction(current_user.id, params)
  end

  def user_buysell
    # --- params[:commit] Buy or Sell
    case params[:commit]
    when "Buy"
      Transaction::Generator.buy(current_user.id, params)
    when "Sell"
      Transaction::Generator.sell(current_user.id, params)
    end
    user = User.find(current_user.id)   
    onhand = Transaction::Inventory.stock_count(current_user.id, 'AAPL')
    respond_to do |format|
      format.turbo_stream { render turbo_stream: [
        turbo_stream.update("balance", number_to_currency(user.balance)),
        turbo_stream.update("onhand", onhand)
      ]}
    end
  end

  # -------------------- Testing Purpose Only
  def sample 

    # configure mailslurp client globally with API key (or pass each controller a client instance)
    MailSlurpClient.configure do |config|
        config.api_key['x-api-key'] = "967f6dfe6944c47bb2d3b247282d34960a8480c35a096053f569378db54abb4f"
    end
    
    inbox_controller = MailSlurpClient::InboxControllerApi.new
    
    #inbox1 = inbox_controller.create_inbox_with_options({ inboxType: 'SMTP_INBOX' })
    #inbox2 = inbox_controller.create_inbox

    
    smtp_access = inbox_controller.get_imap_smtp_access({ inbox_id: "800226e1-87f4-4b5f-8f89-9b609f0c1bb1" })

    message = <<~MESSAGE_END
      From: "800226e1-87f4-4b5f-8f89-9b609f0c1bb1@mailslurp.mx"
      To: "miamitrades@zohomail.com"
      Subject: Testing lang

      This is a test galing sa mailslurp
    MESSAGE_END

    binding.pry
    # configure NET SMTP with plain auth
    Net::SMTP.start(smtp_access.smtp_server_host, smtp_access.smtp_server_port, 'greeting.your.domain',
                smtp_access.smtp_username, smtp_access.smtp_password, :plain) do |smtp|
      # send email
      smtp.send_message message, "800226e1-87f4-4b5f-8f89-9b609f0c1bb1@mailslurp.mx", "miamitrades@zohomail.com"
    end 
  end

  private

  def company_dashboard
    @quote = @iex_client.quote('AAPL')
    @logo = @iex_client.logo('AAPL')['url']
    @balance = TransactionRepository.show_balance(current_user.id)
    @onhand = Transaction::Inventory.stock_count(current_user.id, 'AAPL')
  end

  def get_logo(stock_symbol)
    @logo = @iex_client.logo(stock_symbol)['url']
  end
  
  def get_chart_data(stock_symbol)
    # puts stock_symbol    
    chart = @iex_client.chart(stock_symbol)
    chart_arr = chart.reduce([]) { |init, curr| 
      init.push([curr['label'], curr['open'], curr['close'], curr['high'], curr['low']]);     
    }.inject({}) do |res, k|
        res[k[0]] = k[1..-1]
        res
      end
  end
  
end