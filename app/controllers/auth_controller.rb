class AuthController < ApplicationController
  
  def signin
    @user = User.new
  end

  def signup
  end

  def signup_next
    
  end

end