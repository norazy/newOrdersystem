class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :menus, :detail_zh, :text
    add_column :menus, :detail_en, :text
    add_column :menus, :ordered_time, :datetime
  end
end
