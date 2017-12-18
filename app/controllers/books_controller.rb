class BooksController < ApplicationController
  before_action :find_book, only: :show
  before_action :nil_book, only: :show

  def index
    @books = Book.all.paginate page: params[:page], per_page: Settings.book.index
  end

  def show
    @review  = @book.reviews.build
    @reviews = @book.reviews.includes :user
    @comment = current_user.comments.build
  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
  end
end
