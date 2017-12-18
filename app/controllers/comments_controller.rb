class CommentsController < ApplicationController
  before_action :find_review, only: :create
  before_action :blank_comment, only: :create

  def create
    create_comment
    create_activity @comment, Settings.activity.comment, current_user
    @comment = current_user.comments.build
    @comments = @review.comments.includes :user
    respond_to do |format|
      format.js
    end
  end

  private

  def create_comment
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = t "comment_created"
    else
      flash[:danger] = t "something_wrong"
    end
  end

  def blank_comment
    return if comment_params[:content].present?
    flash[:danger] = t "blank_comment"
    redirect_to @review.book
  end

  def comment_params
    params.require(:comment).permit :content, :review_id
  end

  def find_review
    @review = Review.find_by id: comment_params[:review_id]
  end
end
