ActiveAdmin.register UserLevel do
  menu priority: 1, label: proc{ I18n.t("active_admin.user_level") }
  permit_params :description, :level
  actions :all, except: [:update, :destroy]
  includes :users

end
