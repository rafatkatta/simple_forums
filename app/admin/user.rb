ActiveAdmin.register User do

  menu priority: 2, label: proc{ I18n.t("active_admin.user") }
  permit_params :email, :password, :password_confirmation,
                :first_name, :last_name, :active, :description

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :first_name
    column :last_name
    column :description
    column :active
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Users Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :user_level_id, label: "User Level",
        as: :select,
        collection: UserLevel.all.map{|ul| [ul.description, ul.id]}
      f.input :active
    end
    f.actions
  end

end
