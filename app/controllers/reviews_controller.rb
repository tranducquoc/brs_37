class ReviewsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy
  before_action :find_book
  before_action :nil_book
  before_action :blank_review, only: :create

  def create
    create_review
    create_activity @review, "review", current_user
    redirect_to @book
  end

  private

  def review_params
    params.require(:review).permit :content, :book_id
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
  end

  def create_review
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:success] = t "review_created"
    else
      flash[:danger] = t "something_wrong"
    end
  end

  def blank_review
    return if review_params[:content].present?
    flash[:danger] = t "blank_review"
    redirect_to @book
  end
end
