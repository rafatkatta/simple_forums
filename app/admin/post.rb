ActiveAdmin.register Post do
  menu priority: 5, label: proc{ I18n.t("active_admin.post") }
  permit_params :content, :user_id, :topic_id

# end

end
