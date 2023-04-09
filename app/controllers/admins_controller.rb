class AdminsController < ApplicationController
  before_action :require_user

  def index
    @user = User.all
  end

end