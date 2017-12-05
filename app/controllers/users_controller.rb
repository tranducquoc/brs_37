class UsersController < ApplicationController
  before_action :logged_in_user, only: :show
  before_action :find_user, only: :show

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "check_your_email"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "please_login"
    redirect_to root_path
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "nil_user"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :full_name, :email, :password, :password_confirmation
  end
end
