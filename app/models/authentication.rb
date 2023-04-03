class Authentication < ApplicationRecord
  include BCrypt

  has_one :user
  has_one :user_type, :through => :user
  validates :username, uniqueness: true

  after_create :generate_token

  def self.login(login_params)
    account = find_by(username: login_params[:username])
    
    if account.present?
        return account if Password.new(account.password) == login_params[:password]
    end
  end

  def self.signup(signup_params)
    password_hash = Password.create(signup_params[:password])

    create(username: signup_params[:username], password: password_hash)
  end

  def generate_token
    self.token = SecureRandom.hex(20)

    self.save
  end
 
end
