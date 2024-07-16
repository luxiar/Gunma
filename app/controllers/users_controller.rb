class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    params[:status] ||= 'active'
    @users = @users.where(active: params[:status] == 'active') unless params[:status] == 'all'
  end

  def show
    @daily_reports = @user.daily_reports.order(created_at: :desc).limit(5).includes(:user)
  end

  def new; end

  def edit; end

  def edit_password
    @user = User.find(params[:id])
    render :edit_password
  end

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

  def update_password
    if @user.update(user_params)
      bypass_sign_in @user if current_user == @user
      redirect_to user_url(@user), notice: 'パスワードが更新されました'
    else
      render :edit_password, layout: 'application', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!

    redirect_to users_url, notice: 'ユーザーが削除されました'
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin, :active)
  end
end
