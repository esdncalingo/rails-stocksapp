class SessionsController < ApplicationController

  def signin
    @auth = Authentication.new
  end

  def signup
    @user = User.new
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
        @user = Authentication.signup(auth_params)
        
        format.html { redirect_to new_userinfo_path }
      else
        render :signup, status: :unprocessable_entity
      end
    end
  end

  #user information
  def new_userinfo
    pp user_params
    @user = User.signup(user_params)
    
    # if @user.save
    #   format.html { redirect_to signin_page_path }
    # end
  end

  #logout
  def signout
    session[:gen_token] = nil
    redirect_to new_session_path
  end

  private

  def auth_params
    params.permit(:username, :password)
  end

  def user_params
    params.permit(:fname, :mname, :lname, :email, :contacts, :address, :usertype_id, :auth_id)
  end

end