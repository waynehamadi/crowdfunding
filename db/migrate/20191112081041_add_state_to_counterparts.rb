class AddStateToCounterparts < ActiveRecord::Migration[6.0]
  def change
    add_column :counterparts, :state, :string
  end
end
