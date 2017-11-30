class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.datetime :publish_date
      t.string :author
      t.integer :the_number_of_pages
      t.text :summary
      t.string :cover_image
      t.float :rating

      t.timestamps
    end
  end
end
