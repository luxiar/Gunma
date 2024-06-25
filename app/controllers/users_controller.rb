class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    case params[:status]
    when 'on_leave'
      @users = User.on_leave
    when 'retired'
      @users = User.retired
    when 'all'
      @users = User.all
    else
      @users = User.active
    end
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

  def retire
    if @user.active? && @user.update_without_password(deleted_at: Time.current)
      redirect_to user_url(@user), notice: 'ユーザーが削除されました'
    else
      redirect_to user_url(@user), alert: 'ユーザーの削除に失敗しました'
    end
  end

  def restore
    if @user.retired? && @user.update_without_password(deleted_at: nil)
      redirect_to user_url(@user), notice: 'ユーザーが復元されました'
    else
      redirect_to user_url(@user), alert: 'ユーザーの復元に失敗しました'
    end
  end

  def destroy
    @user.destroy!

    redirect_to users_url, notice: 'ユーザーが完全に削除されました'
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end
end
