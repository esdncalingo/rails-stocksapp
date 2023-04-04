class AuthController < ApplicationController
    
  def signin
    @auth = Authentication.new
  end

  def signup
  end

  def new_session
    respond_to do |format|
      if user = Authentication.login(user_params)
        #request.headers['Authorization'] = user
        format.html { redirect_to home_path }
        format.json { render json: { token: user.token }, status: 200 }
      else
        format.html { render json: { not_found: true }, status: 403 }
      end
    end
  end

  def new_account
    respond_to do |format|
      if (user_params[:password] === params[:password_confirmation])
        @user = Authentication.signup(user_params)
        
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("signup", partial: "auth/form_user")
        end
      else
        render :signup, status: :unprocessable_entity
      end
    end
  end
  
  def logout
    # current_user.token = ""
    # current_user.save
  end

  private

  def user_params
    params.permit(:username, :password)
  end

end