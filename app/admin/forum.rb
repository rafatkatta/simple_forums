ActiveAdmin.register Forum do

  menu priority: 3, label: proc{ I18n.t("active_admin.forum") }, if: proc{current_user.has_admin_level?}
  permit_params :name , :description, :admin, :full_name, :admin_id

  form do |f|
    f.inputs "Forums Details" do
      f.input :admin_id, as: :hidden, input_html: {value: current_user.id}
      f.input :name
      f.input :description, as: :string
    end
    f.actions
  end

  member_action :js_topic, method: :post do
    @forum_id = resource.id
    respond_to :js
  end
  
end
