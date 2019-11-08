class CreateContributions < ActiveRecord::Migration[6.0]
  def change
    create_table :contributions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :counterpart, null: false, foreign_key: true
      t.integer :amount_in_cents
      t.timestamps
    end
  end
end
