ActiveAdmin.register Topic do
  menu priority: 4, label: proc{ I18n.t("active_admin.topic") }
  permit_params :name , :last_poster_full_name, :forum_id, :user_id,
                :full_name, :poster_full_name, :last_post_at


  index do
    selectable_column
    id_column
    column :name
    column :full_name
    column :last_poster_full_name
    column :last_posted
    actions
  end

  filter :name
  filter :last_poster_full_name
  filter :last_post_at
  filter :created_at

  form do |f|
    f.inputs "Topic Details" do
      f.input :forum_id, label: "Forum",
        as: :select,
        collection: Forum.all.map{|f| [f.name, f.id]}
      f.input :user_id, label: "User",
        as: :select,
        collection: User.all.map{|u| [u.full_name, u.id]}
      f.input :name
    end
    f.actions
  end

  member_action :js_comment, method: :post do
    @topice_id = resource.id
    respond_to :js
  end

end
#|t|
