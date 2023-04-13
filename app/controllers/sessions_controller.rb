class SessionsController < ApplicationController
  before_action :require_user, only: [:signin, :signup, :userinfo]

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

        if user.user_level === 2 # --- admin ---
          session[:is_admin] = true
          Login.time_in(user.user_id)
          format.html { redirect_to admin_path }
          format.json { render json: { token: user.token }, status: 200 }
        else # --- trader ---
          Login.time_in(user.user_id)
          format.html { redirect_to home_path }
          format.json { render json: { token: user.token }, status: 200 }
        end
      else
        format.html { render json: { not_found: true }, status: 403 }
      end
    end
  end

  #logout
  def signout
    user = Authentication.find_by(token: session[:gen_token])
    if user.user_level === 2
      session[:is_admin] = false
    end
    
    user.update(is_active: false)
    Login.time_out(user.user_id)
    session[:gen_token] = nil
    redirect_to new_session_path
  
  end

  #signup
  def new_account
    respond_to do |format|
      if (auth_params[:password] === params[:password_confirmation])
        if @user = User.create_user(auth_params)
          format.html { redirect_to new_userinfo_path(id: @user.id) }
        end
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

  private
  def admin_params
    params.permit(:username, :password)
  end

  def auth_params
    params.permit(:username, :password, :email)
  end

  def user_params
    params.permit(:fname, :mname, :lname, :contacts, :address, :id)
  end

end