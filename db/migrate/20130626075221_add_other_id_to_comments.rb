class AddOtherIdToComments < ActiveRecord::Migration
  def change
    add_column :photos, :other_id, :integer
    add_index  :photos, :other_id
  end
end
