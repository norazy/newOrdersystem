class RemoveOrderedtimeFromMenus < ActiveRecord::Migration[5.2]
  def change
    remove_column :menus, :ordered_time, :datetime
  end
end
