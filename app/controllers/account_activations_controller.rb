class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      flash[:success] = t "activate_success"
      user.activate
      log_in user
      redirect_to user
    else
      flash[:danger] = t "activate_danger"
      redirect_to root_path
    end
  end
end

viet tao hfvjh
