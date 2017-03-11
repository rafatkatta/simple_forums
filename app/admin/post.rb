ActiveAdmin.register Post do
  #belongs_to :topic
  menu false #priority: 5, label: proc{ I18n.t("active_admin.post") }
  permit_params :content, :poster_id, :topic_id, :created_at, :posted

  index do
    selectable_column
    id_column
    column :content
    column :full_name
    column :posted
    actions
  end

  form do |f|
    f.inputs "Post Details" do
      f.input :topic_id, label: "Topic",
        as: :select,
        collection: Topic.all.map{|f| [f.name, f.id]}
      f.input :poster_id, label: "User",
        as: :select,
        collection: User.all.map{|u| [u.full_name, u.id]}
      f.input :content, as: :text, label: "Post"
    end
    f.actions
  end

  member_action :js_comment, method: :post do
    @post_id = resource.id
    @poster_id = current_user.id
    respond_to :js
  end

  member_action :js_add_post, method: :post do
    Post.create!(poster: current_user, content: params[:post][:content],
                  topic_id: params[:topic][:topic_id])
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

end
