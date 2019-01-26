class CreateOptiontables < ActiveRecord::Migration[5.2]
  def change
    create_table :optiontables do |t|
      t.text        :name_opt
      t.integer     :price_opt
      t.timestamps
    end
  end
end
