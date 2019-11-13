class AddAasmStateToContributions < ActiveRecord::Migration[6.0]
  def change
    add_column :contributions, :aasm_state, :string
  end
end
