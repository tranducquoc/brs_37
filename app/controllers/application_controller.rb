class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include LoginHelper

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "please_login"
    redirect_to root_path
  end

  def nil_user
    return if @user
    flash[:danger] = t "nil_user"
    redirect_to users_path
  end

  def find_user
    @user = User.find_by id: params[:id]
  end

  def admin_user
    return if current_user.is_admin?
    flash[:danger] = t "not_admin"
    redirect_to root_path
  end
end
