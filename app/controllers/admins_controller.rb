class AdminsController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:update_user, :edit_user, :show_user, :filter_order]
  before_action :user_display, only: [:userpage, :waiting_list, :active_users, :search_user]

  def index; end

  def new_user
    respond_to do |format|
      format.turbo_stream { render turbo_stream:
        turbo_stream.update("dashboard", partial: "admins/users/new_user")
      }
    end
  end

  def create_user
    User.admin_create_user(user_params)
  end

  def edit_user
    respond_to do |format|
      format.turbo_stream { render turbo_stream:
        turbo_stream.update("dashboard", partial: "admins/users/edit_user", locals: {user: @user})
      }
    end
  end

  def show_user
    @portfolio = Transaction::Portfolio.display(params[:user_id])
    @user_history = Transaction::History.show(params[:user_id], params[:kind])   
    respond_to do |format|
      format.turbo_stream { render turbo_stream: [
        turbo_stream.update("dashboard", partial: "admins/users/show_user", locals: { user: @user }),
        turbo_stream.update("portfolio", partial: "admins/users/portfolio", locals: { portfolio: @portfolio }),
        turbo_stream.update("transaction_history", partial: "admins/users/transaction", locals: { user_history: @user_history, user: @user })
        ]}
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
        UserMailer.send_activated_email(params[:email]).deliver_later
        format.turbo_stream { render turbo_stream:
          [
            turbo_stream.update("ud#{user.id}", partial: "admins/users/users", locals: { user: user }),
            turbo_stream.remove("ud#{user.id}")
          ]
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
        turbo_stream.update("dashboard", partial: "admins/users/userlist", locals: { user: @user })
      }
    end
  end

  def filter_order 
    @user_history = Transaction::History.show(params[:user_id], params[:commit])
    respond_to do |format|
      format.turbo_stream { render turbo_stream: 
        turbo_stream.update("transaction_history", partial: "admins/users/transaction", locals: { user_history: @user_history })
      }
    end
  end

  def active_users 
    respond_to do |format|
      format.turbo_stream { render turbo_stream:
        turbo_stream.update("dashboard", partial: "admins/users/userlist", locals: { user: @user })
      }
    end
  end

  def search_user
    @user =  User.where('fname LIKE (?) OR lname LIKE (?) OR mname LIKE (?)', "%#{params[:user_search]}%", "%#{params[:user_search]}%", "%#{params[:user_search]}%")
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("usertable", partial: "admins/users/usertable",locals: {user: @user})
        ]
      end
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
      @user = User.order(created_at: :desc)
    when "waiting_list"
      @user = User.order(created_at: :desc).where(status: "pending")
    when "active_users"
      @user = User.joins(:authentication).where( authentication: { is_active: true })
    end
  end
end