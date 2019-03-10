class AddNameToOptiontables < ActiveRecord::Migration[5.2]
  def change
    add_column :optiontables, :name_opt_zh, :text
    add_column :optiontables, :name_opt_en, :text
  end
end
