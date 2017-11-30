class LoginController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:login][:email].downcase
    if @user && @user.authenticate(params[:login][:password])
      login_success
    else
      flash[:danger] = t "login_fail"
    end
    redirect_to root_path
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def login_success
    flash[:success] = t "login_success"
    log_in @user
    remember @user if params[:login][:remember_me] == Settings.remember_me.checked
  end
end
