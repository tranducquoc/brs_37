class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :find_user, only: %i(show edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :nil_user, only: :show

  def index
    @users = User.paginate page: params[:page], per_page: 20
  end

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

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
  end

  def correct_user
    return if current_user? @user
    flash[:danger] = t "cant_edit"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :full_name, :email, :password, :password_confirmation, :avatar
  end
end
