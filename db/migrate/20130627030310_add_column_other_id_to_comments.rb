class AddColumnOtherIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :other_id, :integer
    add_index  :comments, :other_id
  end
end
