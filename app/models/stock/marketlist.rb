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
			IexCloud.news('/batch?types=news&range=1m&last=5&')
		end
	end
end