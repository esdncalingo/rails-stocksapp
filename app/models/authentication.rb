class Authentication < ApplicationRecord
  include BCrypt

  belongs_to :user

  validates :username, uniqueness: true
  validates :username, :password, presence: true

  after_create :generate_token

  def self.login(login_params)
    account = find_by(username: login_params[:username])
    
    if account.present? && account.is_active? == false
      print Password.new(account.password) == login_params[:password]
      if Password.new(account.password) == login_params[:password]
        account.update(
          is_active: true
        )
        return account
      end
    end
  end

  def self.signup(signup_params)
    user = User.find_by(email: signup_params[:email])
    password_hash = Password.create(signup_params[:password])

    if user
      create(user_id: user.id, username: signup_params[:username], password: password_hash, user_level: 1)
    end
  end

  def generate_token
    self.token = SecureRandom.hex(20)

    self.save
  end
 
end
