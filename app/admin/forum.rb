ActiveAdmin.register Forum do

  menu priority: 3, label: proc{ I18n.t("active_admin.forum") }, if: proc{current_user.has_admin_level?}
  permit_params :name , :description, :admin, :full_name, :admin_id
  includes :topics

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

  member_action :js_delete, method: :delete do
    Forum.find(params[:id]).destroy
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  member_action :js_edit, method: :post do
    @forum = Forum.find(params[:id])
    respond_to :js
  end

  member_action :js_update, method: :post do
    if params[:commit] == "update"
      @forum = Forum.find(params[:forum][:forum_id])
      @forum.update_attributes(name: params[:forum][:name],description: params[:forum][:description])
    end
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

end
