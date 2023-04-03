class AuthController < ApplicationController
  include BCrypt
  
  def signin
    @auth = Authentication.new
  end

  def signup
  end


  def new_session
    respond_to do |format|
      @auth.login(user_params)
    end
  end

  def new_account
    respond_to do |format|
      if (signup_params[:password] === params[:password_confirmation])
        @user = Authentication.new(signup_params)
        @user.password = Password.create(signup_params[:password])

        if @user.save
          format.turbo_stream do
            render turbo_stream: turbo_stream.update("signup", partial: "auth/signup_next")
          end
        end

      else
        print "this is error notice ??????"
        render :signup, status: :unprocessable_entity
      end
    end
  end

  #this if for testing purpose only
  def signup_next
    
  end

  def logout
  end

  

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def signup_params
    params.permit(:username, :password, :user_id)
  end

end