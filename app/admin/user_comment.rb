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

end
