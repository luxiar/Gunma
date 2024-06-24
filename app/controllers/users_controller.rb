class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.where(deleted_at: nil)
  end

  def retired
    @users = @users.where.not(deleted_at: nil)
    render :index
  end

  def all
    render :index
  end

  def show
    @user ||= current_user
    @daily_reports = @user.daily_reports.order(created_at: :desc).limit(5)
  end

  def new; end

  def edit; end

  def create
    if @user.save
      redirect_to user_url(@user), notice: 'ユーザーが作成されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: 'ユーザーが更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.active? && @user.update_without_password(deleted_at: Time.current)
      redirect_to users_url, notice: 'ユーザーが削除されました'
    else
      redirect_to users_url, alert: 'ユーザーの削除に失敗しました'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end
end
