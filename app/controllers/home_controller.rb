class HomeController < ApplicationController
  #before_action :authenticate_user
  before_action :require_user
  before_action :initialize_iex_client
  before_action :is_admin

  def index
    #store in global variable stocks masterlist
    response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_ed7475c0c153436587bd10b8f1da9916') 
    $stocks_master = JSON.parse(response.body)   
    # $stocks_master = response
    # $stocks_master = JSON.parse(response.body)   
    $stocks_master = response
    
    userauth = Authentication.find_by(token: session[:gen_token])
    pending = userauth.user.status === "pending" ? true : false

    if pending 
      redirect_to pending_page_path
    end
  end

  def pending
  end

  def sample 

    # configure mailslurp client globally with API key (or pass each controller a client instance)
    MailSlurpClient.configure do |config|
        config.api_key['x-api-key'] = "967f6dfe6944c47bb2d3b247282d34960a8480c35a096053f569378db54abb4f"
    end
    
    inbox_controller = MailSlurpClient::InboxControllerApi.new
    
    #inbox1 = inbox_controller.create_inbox_with_options({ inboxType: 'SMTP_INBOX' })
    #inbox2 = inbox_controller.create_inbox

    binding.pry
    smtp_access = inbox_controller.get_imap_smtp_access({ inbox_id: inbox1.id })

    message = <<~MESSAGE_END
      From: #{inbox1.email_address}
      To: #{inbox2.email_address}
      Subject: Testing lang boss

      This is a test galing sa mailslurp
    MESSAGE_END

    # configure NET SMTP with plain auth
    Net::SMTP.start(smtp_access.smtp_server_host, smtp_access.smtp_server_port, 'greeting.your.domain',
                smtp_access.smtp_username, smtp_access.smtp_password, :plain) do |smtp|
      # send email
      smtp.send_message message, inbox1.email_address, inbox2.email_address
    end


    
  end

end