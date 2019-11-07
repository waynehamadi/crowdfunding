class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.text :long_description
      t.string :short_description
      t.string :landscape_image
      t.string :thumbnail_image
      t.integer :goal_amount

      t.timestamps
    end
  end
end
