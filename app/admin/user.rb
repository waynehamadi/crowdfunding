ActiveAdmin.register User do
  permit_params :email, :birth_date, :first_name, :last_name, :password, :password_confirmation
  member_action :impersonate do
    sign_in(:user, resource)
    redirect_to after_sign_in_path_for(resource)
  end
  action_item :impersonate, only: :show do
    link_to('Se connecter', impersonate_admin_user_path(resource), target: '_blank')
  end
  index do
    selectable_column
    id_column
    column :email
    column :last_name
    column :first_name
    column :created_at
    column :updated_at
    column :sign_in_count
    column :last_sign_in_at
    column :last_sign_in_ip
    actions
  end

  filter :email
  filter :last_name
  filter :first_name
  filter :created_at
  filter :last_sign_in_at
  filter :sign_in_count

  form do |f|
    f.inputs "User" do
      f.input :email
      f.input :first_name
      f.input :last_name
      if f.object.new_record?
        f.input :birth_date
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end
  show do
    panel '' do
      attributes_table_for resource do
        row :email
        row :last_name
        row :first_name
        row :created_at
        row :updated_at
        row :sign_in_count
        row :last_sign_in_at
        row :last_sign_in_ip
      end
    end
  end
end
