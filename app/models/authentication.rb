class Authentication < ApplicationRecord
  include BCrypt

  has_one :users
  has_one :user_types, :through => :users
  validates :username, uniqueness: true

  def generate_token
    self.token = SecureRandom.hex(20)
  end

  def self.login(login_params)
    account = find_by(username: login_params[:username])

    if user.present?
        return account if Password.new(account.password) == login_params[:password]
    end
end
 
end
