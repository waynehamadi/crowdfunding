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
    first = project.contributions.minimum(:amount_in_cents)
    last = project.contributions.maximum(:amount_in_cents)
    sum = project.contributions.sum(:amount_in_cents).fdiv(100).to_s
    div do
      h4 'Current contributions: ' + sum + '€'
      h4 'Percent Done: ' + project.percent_done.round.to_s + '%'
      h3 'Contributions:'
      h4 'Lowest: ' + first.fdiv(100).to_s + '€' if first
      h4 'Highest: ' + last.fdiv(100).to_s + '€' if last
    end
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
    h1 'Contributions:'
    table_for project.contributions do
      column(:user)
      column(:amount_in_cents)
      column(:counterpart)
      column :created_at
    end
  end


end


