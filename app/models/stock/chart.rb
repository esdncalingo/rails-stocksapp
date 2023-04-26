class Stock 
  # before_action :initialize_iex_client 
  class Chart
    IEX_CLIENT = IEX::Api::Client.new
    # @iex_client = API::Client.initialize_iex_client
    def self.candle(stock_symbol)      
      chart = IEX_CLIENT.chart(stock_symbol)
      chart_arr = chart.reduce([]) { |init, curr| 
        init.push([curr['label'], curr['open'], curr['close'], curr['high'], curr['low']]);     
      }.inject({}) do |res, k|
          res[k[0]] = k[1..-1]
          res
        end
    end
  end
end