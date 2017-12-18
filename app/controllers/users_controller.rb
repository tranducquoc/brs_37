class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :find_user, except: %i(index create new)
  before_action :correct_user, only: %i(edit update)
  before_action :nil_user, only: %i(show destroy)
  before_action :admin_user, only: :destroy
  before_action :important, only: :destroy
  def index
    @users = User.paginate page: params[:page], per_page: Settings.user.index
  end

  def show
    @buy_requests = @user
      .buy_requests
      .paginate page: params[:buy_request_page], per_page: Settings.user.show_buy_request
    @activities = @user
      .activities
      .arrange
      .includes(:user)
      .paginate page: params[:activity_page], per_page: Settings.user.show_activities
  end

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

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "something_wrong"
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def correct_user
    return if current_user? @user
    flash[:danger] = t "cant_edit"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :full_name, :email, :password, :password_confirmation, :avatar
  end

  def important
    return unless @user.is_admin?
    flash[:danger] = t "cant_delete_important"
    redirect_to root_path
  end
end
