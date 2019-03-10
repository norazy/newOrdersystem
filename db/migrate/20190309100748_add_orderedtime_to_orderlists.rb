class AddOrderedtimeToOrderlists < ActiveRecord::Migration[5.2]
  def change
    add_column :orderlists, :ordered_time, :datetime
  end
end
