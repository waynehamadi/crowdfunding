class AddStockToCounterparts < ActiveRecord::Migration[6.0]
  def change
    add_column :counterparts, :stock, :float, :default => Float::INFINITY
  end
end
