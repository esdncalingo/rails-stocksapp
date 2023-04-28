require 'rails_helper'

RSpec.describe User, type: :model do

  # it 'can edit account' do
  #   User.create_user({:username => "danielc", :password => "12345678", :email => "daniel@email.com"})
  #   user = User.find_by(email: "daniel@email.com")
  #   expect(User.signup({:id => user.id, :email => "daniel@email.com", :fname => "daniel"}))
  # end

  # it 'admin can create new account' do
  #   expect(User.admin_create_user({:email => "testperson@email.com"}))
  # end

  # it 'admin can edit trader account details' do
  #   User.create_user({:username => "danielc", :password => "12345678", :email => "daniel@email.com"})
  #   expect(User.patch({
  #     email: "daniel@email.com",
  #     fname: "daniel",
  #     mname: "nav",
  #     lname: "calingo"
  #   }))
  # end

end
