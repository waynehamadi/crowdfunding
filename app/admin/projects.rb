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
    lowest_contribution = project.contributions.minimum(:amount_in_cents)
    highest_contribution = project.contributions.maximum(:amount_in_cents)
    total_contributed = project.contributions.sum(:amount_in_cents).fdiv(100).to_s
    div do
      h4 'Total contributed: ' + total_contributed + '€'
      h4 'Percent Done: ' + project.percent_done.round.to_s + '%'
      h3 'Contributions:'
      h4 'Lowest: ' + lowest_contribution.fdiv(100).to_s + '€' if lowest_contribution
      h4 'Highest: ' + highest_contribution.fdiv(100).to_s + '€' if highest_contribution
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
        h1 'Contributions:'
    table_for project.contributions do
      column(:user)
      column(:amount_in_cents)
      column(:counterpart)
      column 'Created at', :created_at
      column(:aasm_state)
    end
    h1 'Counterparts:'
    table_for project.counterparts do
      column(:name).pluck(:name)
      column(:amount_in_cents).pluck(:amount_in_cents)
      column(:stock).pluck(:stock)
      column do |counterpart|
        link_to edit_admin_counterpart_path(counterpart.id, project: project) do
          'Edit'
        end
      end
      column do |counterpart|
        link_to 'Delete', admin_counterpart_path(counterpart.id, project: project.id), method: :delete, data: { confirm: 'Are you sure?' }
      end
    end
  end
  # action_item :preview, only: :show do
  #   link_to 'preview', project_path(resource)
  # end
end


