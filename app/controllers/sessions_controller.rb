class SessionsController < ApplicationController

  def signin
    @auth = Authentication.new
  end

  def signup
    @user = User.new
  end

  def userinfo
  end

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

  def new_account
    respond_to do |format|
      if (auth_params[:password] === params[:password_confirmation])
        @user = Authentication.signup(auth_params)
        
        format.html { redirect_to userinfo_path }
      else
        render :signup, status: :unprocessable_entity
      end
    end
  end

  def new_userinfo
    respond_to do |format|
    @user = User.new(user_params)
    @user.usertype_id = 2,
    @user.auth_id = Authentication.last.id

    
      if @user.save
        format.html { redirect_to signin_page_path }
      else
        render :userinfo, status: :unprocessable_entity
      end
    end
  end
  
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