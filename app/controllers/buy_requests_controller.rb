class BuyRequestsController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :admin_user, only: :index

  def index
    @buy_requests = BuyRequest
      .sort_by_status
      .sort_by_time
      .paginate page: params[:page], per_page: Settings.buy_requests.index
  end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def admin_user
    return if current_user.is_admin?
    flash[:danger] = t "not_admin"
    redirect_to root_path
  end
end
