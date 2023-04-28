require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe "Trader" do

    it 'can signin' do
      post "/signin", params: {username: "danielc", password: "12345678"}
      expect(response).to have_http_status(302)
    end

  end
end
