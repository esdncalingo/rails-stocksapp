class AdminsController < ApplicationController
  before_action :require_user
  before_action :set_user, only: [:update_user, :edit_user, :show_user]
  before_action :user_display, only: [:userpage, :waiting_list, :active_users]

  def index; end

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

  def show_user
    respond_to do |format|
      format.turbo_stream { render turbo_stream:
        turbo_stream.update("dashboard", partial: "admins/users/show_user", locals: {user: @user})
      }
    end
  end

  def update_user
    User
    .patch(params.require('user')
    .permit(:email, :fname, :mname, :lname, :contacts, :address))
  end

  def activate_user
    respond_to do |format|
      user = User.find_by(email: params[:email])
      if user.update(status: "approved")
        format.turbo_stream { render turbo_stream:
          turbo_stream.update("ud#{user.id}", partial: "admins/users/users", locals: { user: user })
        }
      end
    end
  end

  # ----- Dashboard -----
  def homepage; end
  def userpage; end

  def waiting_list
    respond_to do |format|
      format.turbo_stream { render turbo_stream:
        turbo_stream.update("dashboard", partial: "admins/users/userlist", locals: { user: $user })
      }
    end
  end

  def active_users 
    @current_user = current_user
  
    respond_to do |format|
      format.turbo_stream { render turbo_stream:
        turbo_stream.update("dashboard", partial: "admins/users/userlist", locals: { user: $user })
      }
    end
  end

  private # -----------------------------------

  def user_params
    params.permit(:email, :fname, :mname, :lname, :contacts, :address, :status)
  end

  def set_user
    @user = User.find_by(email: params[:email])
  end

  def user_display
    @current_user = current_user
    case params[:action]
    when "userpage"
      $user = User.order(created_at: :desc)
    when "waiting_list"
      $user = User.order(created_at: :desc).where(status: "pending")
    when "active_users"
      $user = User.joins(:authentication).where( authentication: { is_active: true })
    end
  end
end