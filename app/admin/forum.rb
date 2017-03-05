ActiveAdmin.register Forum do

  menu priority: 3, label: proc{ I18n.t("active_admin.forum") }
  permit_params :name , :description, :full_name

  admin_users = User.joins(:user_level).where(user_level_id: [0,1])

  form do |f|
    f.inputs "Forums Details" do
      f.input :full_name, as: :select,
              collection: admin_users.map{|au| [au.full_name, au.id]},
              include_blank: false
      f.input :name
      f.input :description, as: :string
    end
    f.actions
  end


end
