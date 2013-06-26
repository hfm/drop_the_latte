class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :photo_id

      t.timestamps
    end
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:photo_id, :created_at]
  end
end
