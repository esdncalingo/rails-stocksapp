require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe "Trader" do

    it 'can signin' do
      post "/signin", params: {username: "danielc", password: "12345678"}
      expect(response).to have_http_status(302)
    end

    it 'cannot access without Admin approval' do
      post "/signin", params: {username: "henri", password: "12345678"}
      expect(response).to have_http_status(302)
    end

    it 'can signup' do
      post "/signup", params: {username: "tester101", password: "12345678", password_confirmation: "12345678", email: "tester101@email.com"}, as: :html
      post "/userinfo", params: {fname: "tester101", mname: "Mtester", lname: "ltester", contacts: "tester contanct", address: "tester address", id: User.last.id}
      expect(response).to have_http_status(302)
    end

    it 'can logout' do
      post "/signin", params: {username: "danielc", password: "12345678"}
      post "/signout"
      expect(response).to have_http_status(302)
    end

  end

  describe "Admin" do
    it 'can signin' do
      post "/signin", params: {username: "admin", password: "12345678"}
      expect(response).to have_http_status(302)
    end
  end
end
