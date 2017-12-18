module BooksHelper
  def load_comment review
    @comments = review.comments.includes :user
  end
end
