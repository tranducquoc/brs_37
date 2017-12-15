class LikesController < ApplicationController
  before_action :logged_in_user
  before_action :find_user
  before_action :nil_user
  before_action :find_activity
  before_action :find_like, only: :destroy

  def create
    unless current_user.likes.create! activity_id: @activity.id
      flash[:danger] = t "something_wrong"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    flash[:danger] = t "something_wrong" unless @like.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def find_activity
    @activity = Activity.find_by id: params[:activity_id]
    return if @activity
    flash[:danger] = t "nil_activity"
    redirect_to @user
  end

  def find_user
    @user = User.find_by id: params[:user_id]
  end

  def find_like
    @like = current_user.likes.find_by activity_id: params[:activity_id]
    redirect_to @user if @like.blank?
  end
end
