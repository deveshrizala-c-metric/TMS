class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check

  def index
    @users = User.without_role :admin
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.destroy
        flash[:success] = 'User deleted successfully'
        format.html { redirect_to deleted_users_path }
      else
        flash[:danger] = 'There is a problem in deleting the user.'
        format.html { redirect_to users_path }
      end
    end
  end

  def deleted
    @users = User.only_deleted
  end

  def restore
    @user = User.only_deleted.find(params[:id])

    respond_to do |format|
      if User.restore(@user.id)
        flash[:success] = 'User restored successfully'
        format.html { redirect_to users_path }
      else
        flash[:danger] = 'There is a problem in restoring the user.'
        format.html { redirect_to users_path }
      end
    end
  end

  private
  def admin_check
    unless current_user.has_role? :admin
      flash[:danger] = 'You need to be admin.'
      redirect_to root_path
    end
  end
end