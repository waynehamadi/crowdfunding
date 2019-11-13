ActiveAdmin.register Counterpart do
  permit_params :name, :amount_in_cents, :project_id

  form do |f|
    all_projects = Project.all.map { |project| ["#{project.name}, goal:#{project.goal_amount}€"] }
    if params[:project]
      h4 "Project: #{Project.find(params[:project]).name.capitalize}"
    end
    f.inputs do
      if params[:project]
        f.input :project_id, input_html: { value: params[:project] }, as: :hidden
      else
        f.input :project
      end
      f.input :name
      f.input :amount_in_cents
    end
    f.actions
  end
  show do
    panel '' do
      attributes_table_for resource do
        row :name
        row :amount_in_cents
      end
    end
  end
end
