class StaticPagesController < ApplicationController
  before_action :activity_home, only: :home

  def home; end

  def help; end

  def contact; end

  def about; end

  private

  def activity_home
    return unless logged_in?
    @activity_items = current_user.activity_feed
      .paginate page: params[:page], per_page: Settings.home.show_activities_feed
  end
end
