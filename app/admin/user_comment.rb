ActiveAdmin.register UserComment do
  #belongs_to :post
  permit_params :content, :post_id, :commenter_id

  index do
    selectable_column
    id_column
    column :content
    column :full_name
    column :post_content
    actions
  end

  member_action :js_add_comment, method: :post do
    UserComment.create!(commenter: current_user,
                        content: params[:post][:content], post_id: params[:id])
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  member_action :js_delete, method: :delete do
    UserComment.find(params[:id]).destroy
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  member_action :js_edit, method: :post do
    @user_comment = UserComment.find(params[:id])
    respond_to :js
  end

  member_action :js_update, method: :post do
    if params[:commit] == "update"
      @comment = UserComment.find(params[:comment][:comment_id])
      @comment.update_attribute(:content, params[:comment][:content])
    end  
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

end
