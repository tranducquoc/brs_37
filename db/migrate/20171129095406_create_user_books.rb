class CreateUserBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_books do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.boolean :is_favourite
      t.integer :status
      t.float :rating

      t.timestamps
    end
  end
end
