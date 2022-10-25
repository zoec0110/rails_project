class UsersController < ApplicationController
  def sign_up
    @user = User.new
  end

  def sign_in
    @user = User.new
  end

  def sign_in_create
    if User.find_by(user_params)
      @user = User.find_by(user_params)
      session[:current_user_id] = @user.id
      redirect_to root_url
    else
      flash[:alert] = '請輸入正確的帳號密碼'
      redirect_to sign_in_users_url
    end
  end

  def sign_up_create
    @user = User.new(user_params)
    if User.find_by(email: @user.email)
      flash[:alert] = 'the email already exited'
      redirect_to sign_up_users_url
    else
      @user.save
      flash[:notice] = '註冊成功，請登入'
      redirect_to sign_in_users_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
