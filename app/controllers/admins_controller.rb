class AdminsController < ApplicationController
  before_action :require_user
  before_action :set_user, only: [:update_user, :edit_user]

  def index
    @user = User.order(created_at: :desc).where(status: "pending")
    @current_user = current_user
  end

  def new_user
    respond_to do |format|
      format.turbo_stream { render turbo_stream:
        turbo_stream.update("dashboard", partial: "admins/users/new_user")
      }
    end
  end

  def create_user
    User.create(user_params).save
  end

  def edit_user
    respond_to do |format|
      format.turbo_stream { render turbo_stream:
        turbo_stream.update("dashboard", partial: "admins/users/edit_user", locals: {user: @user})
      }
    end
  end

  def update_user
    User
    .patch(params.require('user')
    .permit(:email, :fname, :mname, :lname, :contacts, :address))
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

  private # -----------------------------------

  def user_params
    params.permit(:email, :fname, :mname, :lname, :contacts, :address)
  end

  def set_user
    @user = User.find_by(email: params[:email])
  end
end