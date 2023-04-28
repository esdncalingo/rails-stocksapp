require 'rails_helper'

RSpec.describe "Traders", type: :request do

  before do
    post "/signin", params: {username: "danielc", password: "12345678"}
  end

  it 'load Homepage return status 200' do
    get '/home'
    expect(response).to have_http_status(200)
  end

end
