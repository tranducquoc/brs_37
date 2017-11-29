class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :full_name
      t.string :email
      t.string :avatar
      t.boolean :is_admin, default: false
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email, unique:true
  end
end
