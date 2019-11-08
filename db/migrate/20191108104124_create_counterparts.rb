class CreateCounterparts < ActiveRecord::Migration[6.0]
  def change
    create_table :counterparts do |t|
      t.string :name
      t.integer :amount_in_cents
      t.float :counterpart, :default => Float::INFINITY

      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
