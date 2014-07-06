class UsersController < ApplicationController
  def index
  @user = User.find_by(params[:id])
  end

  def show
  
  @user = User.find_by(params[:id])
  end

  def new
  end
end
