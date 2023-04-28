require 'rails_helper'

RSpec.describe User, type: :model do

  it 'can create new account' do
    expect(User.create_user({:username => "danielc", :password => "12345678", :email => "daniel@email.com"})).to be_valid
  end
  
  it 'can signin' do
    User.create_user({:username => "danielc", :password => "12345678", :email => "daniel@email.com"})
    expect(Authentication.login({:username => "danielc", :password => "12345678"})).to be_valid
  end

end
