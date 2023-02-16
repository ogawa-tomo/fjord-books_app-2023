class UsersController < ApplicationController
  
  def index
    @users = User.page(params[:page]).per(10)
  end
  
  def show
    @user = current_user
  end
end
