ActiveAdmin.register Counterpart do
  permit_params :name, :amount_in_cents

  form do |f|
    f.inputs do
      f.input :name
      f.input :amount_in_cents
      f.input :stock
      f.input :state
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
