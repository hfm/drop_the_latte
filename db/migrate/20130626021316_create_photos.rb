class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.datetime :took_date
      t.integer :user_id

      t.timestamps
    end
    add_index :photos, [:user_id, :created_at]
  end
end
