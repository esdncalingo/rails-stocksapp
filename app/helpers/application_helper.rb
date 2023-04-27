module ApplicationHelper
  def check_logo(stock_symbol)
    if newarray = $stocks_master.find { |item| item['symbol'] == stock_symbol }
      if newarray['url']
        newarray['url']
      else
        newarray['url'] = IEX_CLIENT.logo(stock_symbol)['url']
        $stocks_master.find { |item| item['symbol'] == stock_symbol ? item.replace(newarray) : '' }
        File.write('./app/helpers/stock_master.json', JSON.dump($stocks_master))
        newarray['url']
      end
    end
  end

  def check_quote(stock_symbol)
    if newarray = $stocks_master.find { |item| item['symbol'] == stock_symbol }
      if newarray['quote']
        newarray['quote']
      else
        newarray['quote'] = IEX_CLIENT.quote(stock_symbol)
        $stocks_master.find { |item| item['symbol'] == stock_symbol ? item.replace(newarray) : '' }
        File.write('./app/helpers/stock_master.json', JSON.dump($stocks_master))
        newarray['quote']
      end
    end
  end

end
