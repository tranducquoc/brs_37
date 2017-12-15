class BuyRequestsController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :admin_user, only: %i(index update)
  before_action :find_request, only: %i(update destroy)
  before_action :right_request, only: :destroy

  def index
    @buy_requests = BuyRequest
      .sort_by_status
      .sort_by_time
      .paginate page: params[:page], per_page: Settings.buy_requests.index
  end

  def create; end

  def edit; end

  def update
    @buy_request.update_attributes request_params
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @buy_request.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "something_wrong"
    end
  end

  private

  def request_params
    params.require(:buy_request).permit :request_status
  end

  def find_request
    @buy_request = BuyRequest.find_by id: params[:id]
    return if @buy_request
    flash[:danger] = t "nil_buy_request"
    redirect_to buy_requests_path
  end

  def right_request
    return if current_user? @buy_request.user
    flash[:danger] = t "cant_edit"
    redirect_to root_path
  end
end
