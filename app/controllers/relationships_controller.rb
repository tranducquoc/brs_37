class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :create
  before_action :load_relationship, only: :destroy
  before_action :nil_user, only: %i(create destroy)

  def create
    current_user.follow @user
    respond_to do |format|
      format.js
    end
  end

  def destroy
    current_user.unfollow @user
    respond_to do |format|
      format.js
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:followed_id]
  end

  def load_relationship
    relationship = Relationship.find_by id: params[:id]
    if relationship
      @user = relationship.followed
    else
      flash[:danger] = t "nil_relationship"
      redirect_to users_path
    end
  end
end
