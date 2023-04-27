class Stock
	class Marketlist

		def self.mostactive
			IEX_CLIENT.stock_market_list(:mostactive)
		end

		def self.gainers
			IEX_CLIENT.stock_market_list(:gainers)
		end

		def self.losers
			IEX_CLIENT.stock_market_list(:losers)
		end

		def self.latest_news
			response = Faraday.get('https://cloud.iexapis.com/v1/stock/market/batch?types=news&range=1m&last=5&token=pk_06f0670b09884fe5aa66d394e4263f00')
    	JSON.parse(response.body)
		end
	end
end