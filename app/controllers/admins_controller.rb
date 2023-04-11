class AdminsController < ApplicationController
  before_action :require_user

  def index
    @user = User.order(created_at: :desc).where(status: "pending")
  end

  def edit_user
  
  end

  def activate_user
    @user = User.order(created_at: :desc).where(status: "pending")
    
    respond_to do |format|
      user = User.find_by(email: params[:email])
      if user.update(status: "approved")
        format.turbo_stream { render turbo_stream:
          turbo_stream.update("usertable", partial: "admins/usertable", locals: { user: @user })
        }
      end
    end
  end

end