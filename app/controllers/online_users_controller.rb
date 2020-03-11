class OnlineUsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def ban_users
    User.where(id: params[:user_ids]).update_all(banned: true)
    render json: { success: 'successfully ban users' }
  end

  def unlock_users
    User.where(id: params[:user_ids]).update_all(banned: false)
    render json: { success: 'successfully ban users' }
  end

  def delete_users
    User.where(id: params[:user_ids]).delete_all
    render json: { success: 'successfully removed users' }
  end

  def set_admin
    User.where(id: params[:user_ids]).each do |user|
      user.remove_role :user
      user.add_role :admin
    end
    render json: { success: 'successfully removed users' }
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     redirect_to action: :index, notice: 'User banned.'
    else
     render 'index'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    # redirect_to online_users_path, notice: 'User deleted.'
    redirect_to action: :index, notice: 'User deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:banned)
  end
end
