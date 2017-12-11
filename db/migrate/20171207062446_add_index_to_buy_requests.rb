class AddIndexToBuyRequests < ActiveRecord::Migration[5.1]
  def change
    add_index :buy_requests, %i(user_id book_id), unique: true
  end
end
