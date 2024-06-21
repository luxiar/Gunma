class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users or /users.json
  def index; end

  # GET /users/1 or /users/1.json
  def show
    @user ||= current_user
    @daily_reports = @user.daily_reports.order(created_at: :desc).limit(5)
  end

  # GET /users/new
  def new; end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    if @user.save
      redirect_to user_url(@user), notice: 'ユーザーが作成されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: 'ユーザーが更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    redirect_to users_url, notice: 'ユーザーが削除されました'
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :admin)
  end
end
