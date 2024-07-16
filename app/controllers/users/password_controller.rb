class Users::PasswordController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    render :edit_password
  end

  def update
    @user = User.find(params[:user_id])
    if @user.update(user_params)
      bypass_sign_in @user if current_user == @user
      redirect_to user_url(@user), notice: 'パスワードが更新されました'
    else
      render :edit_password, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
