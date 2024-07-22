class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    params[:status] ||= 'active'
    @users = @users.where(active: params[:status] == 'active') unless params[:status] == 'all'
  end

  def show
    @daily_reports = @user.daily_reports.order(created_at: :desc).limit(5).includes(:user, :learned_tags, :thumbs_ups)
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
    if @user.update_without_password(user_params)
      redirect_to user_url(@user), notice: 'ユーザーが更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!

    url = @user == current_user ? root_url : users_url
    redirect_to url, notice: 'ユーザーが削除されました'
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :admin, :active, :password, :password_confirmation)
  end
end
