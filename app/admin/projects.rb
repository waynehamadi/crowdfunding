ActiveAdmin.register Project do
  permit_params :name, :goal_amount, :image, :landscape_image, :thumbnail_image

  index do
    selectable_column
    id_column
    column :name
    column :goal_amount
    column :created_at
    actions
  end
  filter :name
  filter :goal_amount
  filter :created_at

  form do |f|
    f.inputs "Project" do
      f.input :name
      f.input :goal_amount
      f.input :category
      f.input :long_description
      f.input :short_description
      f.input :landscape_image, as: :file
      f.input :thumbnail_image, as: :file
    end
    f.actions
  end
  show do
    panel '' do
      attributes_table_for resource do
        row :name
        row :goal_amount
        row :category
        row :long_description
        row :short_description
        row :landscape_image do
          image_tag(resource.landscape_image.url)
        end
        row :thumbnail_image do
          image_tag(resource.thumbnail_image.url)
        end
      end
    end
  end


end
