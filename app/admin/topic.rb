ActiveAdmin.register Topic do
  #belongs_to :forum
  menu false #priority: 4, label: proc{ I18n.t("active_admin.topic") }
  permit_params :name , :last_poster, :forum_id, :user_id,
                :full_name, :last_post_at


  index do
    selectable_column
    id_column
    column :name
    column :full_name
    column :last_poster
    column :last_posted
    actions
  end

  filter :name
  filter :last_poster
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

  member_action :js_add_topic, method: :post do
    Topic.create!(user: current_user, name: params[:topic][:name],
                  forum_id: params[:forum][:forum_id])
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  member_action :js_post, method: :post do
    @topic_id = resource.id
    respond_to :js
  end

end
#|t|
