require 'rails_helper'

RSpec.describe "Admins", type: :request do
  before do
    post "/signin", params: {username: "admin", password: "12345678"}
  end

  it 'can direct to dashboard return status 200' do
    get "/admin"
    expect(response).to have_http_status(200)
  end

  describe 'load page' do
    it 'user lists' do
      post "/admin/userpage", as: :turbo_stream
      expect(response).to have_http_status(200)
    end

    it 'new user' do
      post "/admin/user/new", as: :turbo_stream
      expect(response).to have_http_status(200)
    end

    it 'online users' do
      post "/admin/user/active", as: :turbo_stream
      expect(response).to have_http_status(200)
    end

    it 'pending users' do
      post "/admin/user/waiting", as: :turbo_stream
      expect(response).to have_http_status(200)
    end

    it 'user portfolio' do
      post "/admin/user/show",params: { email: "daniel@email.com", user_id: 1 }, as: :turbo_stream
      expect(response).to have_http_status(200)
    end

    it 'buy list' do
      post "/admin/user/filter_order", params: {user_id: 1, commit: "Buy"}, as: :turbo_stream
      expect(response).to have_http_status(200)
    end

    it 'searched user' do
      post "/admin/user/search", params: {user_search: "dan"}, as: :turbo_stream
      expect(response).to have_http_status(200)
    end
  end

  it 'create new user' do
    post "/admin/user/new", as: :turbo_stream
    post "/admin/user/create",params: {
      username: "tester101", 
      password: "12345678", 
      password_confirmation: "12345678", 
      email: "tester101@email.com", 
      status: "pending"
    }, as: :turbo_stream
    expect(response).to have_http_status(204)
  end

  it 'can edit user' do
    post "/admin/user", params: { email: "daniel@email.com" }, as: :turbo_stream
    patch "/admin/user", 
    params: 
      { 
      user: 
        {
          email: "daniel@email.com",
          fname: "daniell", 
          mname: "navi", 
          lname: "calingo", 
          contacts: "secret", 
          address: "rizal"
        } 
      }, as: :turbo_stream
    expect(response).to have_http_status(204)
  end

  it 'can approve/activate user' do
    post "/admin/user/activate", params: { email: "daniel@email.com" }, as: :turbo_stream
    expect(response).to have_http_status(200)
  end
end
