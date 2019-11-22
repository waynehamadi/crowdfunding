class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.integer :amount
      t.integer :fees
      t.string :bic
      t.string :iban
      t.string :ref
      t.date :date
      t.string :currency
      t.timestamps
    end
  end
end
