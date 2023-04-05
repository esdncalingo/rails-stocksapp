class SessionsController < ApplicationController

  def signin
  end

  def signup
  end

  def userinfo
  end

  #login
  def new_session
    respond_to do |format|
      if user = Authentication.login(auth_params)
        session[:gen_token] = user.token
        format.html { redirect_to home_path }
        format.json { render json: { token: user.token }, status: 200 }
      else
        format.html { render json: { not_found: true }, status: 403 }
      end
    end
  end

  #signup
  def new_account
    respond_to do |format|
      if (auth_params[:password] === params[:password_confirmation])
        @user = User.create_user(auth_params)
        
        format.html { redirect_to new_userinfo_path(id: @user.id) }
      else
        render :signup, status: :unprocessable_entity
      end
    end
  end

  # additional user information
  def new_userinfo
    @user = User.signup(user_params)
    redirect_to new_session_path
  end

  #logout
  def signout
    session[:gen_token] = nil
    redirect_to new_session_path
  end

  private

  def auth_params
    params.permit(:username, :password, :email)
  end

  def user_params
    params.permit(:fname, :mname, :lname, :contacts, :address, :id)
  end

end