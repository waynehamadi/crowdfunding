ActiveAdmin.register Category do
  permit_params :name
  actions :all, except: :show

  index do
    id_column
    column :name
    column :created_at
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs "User" do
      f.input :name
    end
    f.actions
  end

  show do
    panel '' do
      attributes_table_for resource do
        row :name
        row :created_at
        row :updated_at
      end
    end
  end
end
