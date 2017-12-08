module BuyRequestHelper
  def user_name_for user_id
    user = User.find_by id: user_id
    user.full_name if user
  end

  def book_title_for book_id
    book = Book.find_by id: book_id
    book.title if book
  end
end
