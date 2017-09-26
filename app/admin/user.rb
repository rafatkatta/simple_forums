ActiveAdmin.register User do

  menu priority: 2, label: proc{ I18n.t("active_admin.user") }
  permit_params :email, :password, :password_confirmation,
                :first_name, :last_name, :user_level_id, :active, :description

  #scope_to :current_user, unless: proc{current_user.has_admin_level?}

  controller do
    disallowed = []
    disallowed << :edit unless proc{current_user.has_admin_level?}
    disallowed << :new if proc{current_user.has_admin_level?}
    disallowed << :delete unless proc{current_user.has_admin_level?}
    actions :all, except: disallowed

    def scoped_collection
      if current_user.has_admin_level?
        User.all
      else
        User.where(id: current_user.id)
      end
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :first_name
    column :last_name
    column :description
    column :active do |user|
      link_to (user.is_active? ? "yes" : "No" ),
            js_change_status_admin_user_path(user.id),remote: true
    end
    actions
  end


  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at


  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :user_level_id, label: "User Level",
        as: :select,
        collection: UserLevel.all.map{|ul| [ul.description, ul.id]}
      f.input :active, as: :boolean,:input_html => { :checked => 'checked' }
    end
    f.actions
  end


  member_action :js_change_status do
      user = User.find(params[:id])
      user.active = !user.active
      user.save!
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
  end

end
