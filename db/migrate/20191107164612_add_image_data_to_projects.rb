class AddImageDataToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :landscape_image_data, :text
    add_column :projects, :thumbnail_image_data, :text
  end
end
