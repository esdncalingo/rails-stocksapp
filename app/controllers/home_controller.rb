class HomeController < ApplicationController
  #before_action :authenticate_user
  before_action :require_user
  before_action :initialize_iex_client

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

  # ------ Load Balance ------
  def deposit
  end

  def buysell
  end

  def market
  end

  def trade
  end

  # ------ balance transactions ------

  def add_balance

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

end