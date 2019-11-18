class AddMangoPayIdToContributions < ActiveRecord::Migration[6.0]
  def change
    add_column :contributions, :mango_pay_id, :string
  end
end
