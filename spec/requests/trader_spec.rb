require 'rails_helper'

RSpec.describe "Traders", type: :request do

  before do
    post "/signin", params: {username: "danielc", password: "12345678"}
  end

  it 'load Homepage return status 200' do
    get '/home'
    expect(response).to have_http_status(200)
  end

  it 'load Stockpage return status 200' do
    get '/buy-sell'
    expect(response).to have_http_status(200)
  end

  it 'can buy stocks return status 200' do
    post '/deposit/addbalance', params: {commit: "Deposit", amount: 200000}
    post '/buy-sell', params: {commit: "Buy", amount: 200}, as: :turbo_stream
    expect(response).to have_http_status(200)
  end

  it 'cannot buy more than his/her balance' do
    post '/buy-sell', params: {commit: "Buy", amount: 1}
    expect(response).to have_http_status(406)
  end

  it 'can sell stocks return status 200' do
    post '/deposit/addbalance', params: {commit: "Deposit", amount: 200000}
    post '/buy-sell', params: {commit: "Buy", amount: 2000, qty: 10, symbol: 'TSLA'}, as: :turbo_stream
    post '/buy-sell', params: {commit: "Sell", amount: 400, qty: 2, symbol: 'TSLA'}, as: :turbo_stream
    expect(response).to have_http_status(200)
  end

  it 'load Marketplace return status 200' do
    get '/market'
    expect(response).to have_http_status(200)
  end

  it 'load Portfolio return status 200' do
    get '/profile'
    expect(response).to have_http_status(200)
  end

  it 'load Order Lists return status 200' do
    get '/transaction'
    expect(response).to have_http_status(200)
  end

  it 'Deposit amount return status 200' do
    post '/deposit/addbalance', params: {commit: "Deposit", amount: 200000}
    expect(response).to have_http_status(200)
  end

  it 'Deposit amount cannot be less than one' do
    post '/deposit/addbalance', params: {commit: "Deposit", amount: 0}
    expect(response).to have_http_status(406)
  end

  it 'can show all bought list' do
    post "/transaction", params: {kind: "Buy"}, as: :turbo_stream
    expect(response).to have_http_status(200)
  end
end
