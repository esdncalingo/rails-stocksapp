class User < ApplicationRecord
  has_one :authentication
  has_many :logins
  has_many :transactions

  before_validation :convert_downcase
  validates :email, uniqueness: true
  validates :email, presence: true

  # user_level { 1 = trader, 2 = admin }

  def self.create_user(params)
    new(
      email: params[:email],
      status: "pending",
    ).save
    Authentication.signup(params)
  end

  def self.admin_create_user(params)
    new(params).save
    user = User.find_by(email: params[:email])
    Authentication.create(user_id: user.id, 
      username: SecureRandom.hex(3), 
      password: SecureRandom.hex(4), 
      user_level: 1).save
  end
  
  def self.signup(user_params)
    user = find(user_params[:id])
    user.update( fname: user_params[:fname],
      mname: user_params[:mname],
      lname: user_params[:lname],
      contacts: user_params[:contacts],
      address: user_params[:address],
    )
  end

  def self.patch(user_params)
    user = find_by(email: user_params[:email])
    user.update(email: user_params[:email],
      fname: user_params[:fname],
      mname: user_params[:mname],
      lname: user_params[:lname],
      contacts: user_params[:contacts],
      address: user_params[:address],
    )
  end

  def convert_downcase
    self.email.downcase! 
    self.fname ? self.fname.downcase! : ""
    self.mname ? self.mname.downcase! : ""
    self.lname ? self.lname.downcase! : ""
    self.address ? self.address.downcase! : ""
  end

end
