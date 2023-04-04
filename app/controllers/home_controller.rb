class HomeController < ApplicationController
  #before_action :authenticate_user
  before_action :require_user

  def index
  end

  def sample 
  end

end