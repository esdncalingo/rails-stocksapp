module IexCloud
  BASE_URL = 'https://cloud.iexapis.com/v1/stock/market'
  TOKEN = Rails.application.credentials.config[:publishable_token]  

  def self.news(endpoint)   
    result = Faraday.get("#{BASE_URL}#{endpoint}&token=#{TOKEN}") 
    JSON.parse(result.body)
  end
end