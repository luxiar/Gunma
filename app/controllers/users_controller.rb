class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = case params[:status]
             when 'on_leave'
               User.on_leave
             when 'retired'
               User.retired
             when 'all'
               User.all
             else
               User.active
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

  def destroy
    @user.destroy!

    redirect_to users_url, notice: 'ユーザーが削除されました'
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin, :status)
  end
end
