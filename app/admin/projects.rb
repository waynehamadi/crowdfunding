ActiveAdmin.register Project do
  permit_params :name, :goal_amount, :image, :landscape_image, :thumbnail_image, :category_id

  action_item :check_state, only: :show do
    link_to 'update state', url_for(action: :check_state) if resource.aasm_state == 'draft' || resource.aasm_state == 'upcoming'
  end
  action_item :csv, only: :show do
    link_to 'Download contributors', csv_download_url(project: resource, format: :csv)
  end
  scope :upcoming
  scope :ongoing
  scope :success
  member_action :check_state do
    transaction = CheckProject.new.call(project: resource)
    redirect_to admin_project_path(resource)
    if transaction.success?
      flash[:success] = "The state successfully has changed to: #{resource.aasm_state}"
    else
      flash[:error] = "The state can't change. Current state:  #{resource.aasm_state}"
    end
  end
  action_item :project_succeeded, only: :show do
    link_to 'Evaluate the project', url_for(action: :project_succeeded) if resource.aasm_state == 'ongoing'
  end
  member_action :project_succeeded do
    transaction = EvaluateProject.new.call(project: resource)
    redirect_to admin_project_path(resource)
    if transaction.success?
      flash[:success] = "Your project is a: #{resource.aasm_state}"
    else
      flash[:error] = 'Failure'
    end
  end
  action_item :new_counterpart, only: :show, if: proc { resource.aasm_state != 'ongoing' } do
    link_to 'new counterpart', new_admin_counterpart_path(project: project.id)
  end
  csv do |format|
    @projects = Project.custom_query # or scope

    format.html
    format.csv   { export_csv @products }
    format.json  { render json: @products }
    format.xml   { render xml: @products }
  end
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
  filter :aasm_state, as: :select, collection: Project.state

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
        row :aasm_state
        row :goal_amount
        row :category
        row :long_description
        row :short_description
        unless resource.landscape_image.nil?
          row :landscape_image do
            image_tag(resource.landscape_image.url)
          end
        end
        unless resource.landscape_image.nil?
          row :thumbnail_image do
            image_tag(resource.thumbnail_image.url)
          end
        end
      end
    end
    h1 'Contributions:'
    table_for project.contributions do
      column(:user)
      column(:amount_in_cents)
      column(:counterpart)
      column :created_at
      column :aasm_state
    end
    h1 'Counterparts:'
    table_for project.counterparts do
      column(:name)
      column(:amount_in_cents)
      column(:stock)
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

end


