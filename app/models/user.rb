class User < ApplicationRecord
  has_one :atuhentication
  has_many :logins

  validates :email, uniqueness: true
  validates :email, presence: true

  # user_level { 1 = trader, 2 = admin }

  def self.create_user(params)
    @user = new
    @user.email = params[:email]
    @user.user_level = 1
    @user.save

    Authentication.signup(params)
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

end
