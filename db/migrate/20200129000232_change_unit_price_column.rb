class ChangeUnitPriceColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :unit_price

    add_column :items, :unit_price, :float
  end
end
