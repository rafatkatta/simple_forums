ActiveAdmin.register_page "Dashboard" do

  menu priority: 0, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default" do
      Forum.includes(topics: {posts: :user_comments}).order(:id).each do |forum|
        div class: "spacing", style: "height: 30px;" do
          hr style: "border: 0;height: 0; box-shadow: 0 0 10px 1px black;"
        end
        tabs do
          tab "Forums" do
            div class: "table" do
              div class: "tr",id: "forum_#{forum.id}" do
                div class: "th" do
                  forum.full_name
                end
                div class: "th" do
                  forum.description
                end
                div class: "th" do
                  forum.name
                end
                div class: "th", style: "float:right;width:100px;" do
                  button_to "Add topic",js_topic_admin_forum_path(forum.id), remote: true
                end
                if current_user == forum.admin && current_user.has_admin_level?
                  div class: "th",style: "float:right;width:100px;" do
                    button_to "edit",js_edit_admin_forum_path(forum.id),
                    remote: true
                  end
                  div class: "th",style: "float:right;width:100px;" do
                    button_to "delete",js_delete_admin_forum_path(forum.id), method: :delete,
                    data: { confirm: 'Are you sure? all topics,posts, and comments will be deleted' }, remote: true
                  end
                end
              end
            end
          end
        end
        div class: "Form_Topics",id: "forum_topic_#{forum.id}"
        forum.topics.each do |topic|
          tabs do
            tab "Topics" do
              div class: "table" do
                div class: "tr", id: "topic_#{topic.id}" do
                  div class: "th" do
                    topic.last_poster
                  end
                  div class: "th" do
                    topic.name
                  end
                  div class: "th" do
                    topic.last_posted
                  end
                  div class: "th", style: "float:right;width:100px;" do
                    button_to "Add Post",js_post_admin_topic_path(topic.id),
                    remote: true
                  end
                  if current_user == topic.user
                    div class: "th",style: "float:right;width:100px;" do
                      button_to "edit",js_edit_admin_topic_path(topic.id),
                      remote: true
                    end
                    div class: "th",style: "float:right;width:100px;" do
                      button_to "delete",js_delete_admin_topic_path(topic.id), method: :delete,
                      data: { confirm: 'Are you sure? all posts and comments will be deleted' }, remote: true
                    end
                  end
                end
              end
            end
          end
          div class: "Topic_Posts", id: "topic_post_#{topic.id}"
          topic.posts.each do |post|
            tabs do
              tab "Posts" do
                div class: "table" do
                  div class: "tr", id: "post_#{post.id}" do
                    div class: "th" do
                     post.full_name
                    end
                    div class: "th", style: "white-space:pre-wrap;" do
                     post.content
                    end
                    div class: "th" do
                     post.posted
                    end
                    if current_user == post.poster
                      div class: "th",style: "float:right;width:100px;" do
                        button_to "edit",js_edit_admin_post_path(post.id),
                        remote: true
                      end
                      div class: "th",style: "float:right;width:100px;" do
                        button_to "delete",js_delete_admin_post_path(post.id), method: :delete,
                        data: { confirm: 'Are you sure? all comments will be deleted' }, remote: true
                      end
                    end
                 end
               end
              end
            end
            tabs do
              tab "Comments" do
            post.user_comments.each do |user_comment|
              div class: "table" do
                div class: "tr", id: "comment_#{user_comment.id}" do
                  div class: "th" do
                    user_comment.full_name
                  end
                  div class: "th" , style: "white-space:pre-wrap;" do
                    user_comment.content
                  end
                  if current_user == user_comment.commenter
                    div class: "th",style: "float:right;width:100px;" do
                      button_to "edit",js_edit_admin_user_comment_path(user_comment.id),
                      remote: true
                    end
                    div class: "th",style: "float:right;width:100px;" do
                      button_to "delete",js_delete_admin_user_comment_path(user_comment.id), method: :delete,
                      data: { confirm: 'Are you sure?' }, remote: true
                    end
                  end
                end
              end
                  end
                end
              end
            div class: "Post_comments", id: "comment_post_#{post.id}", style: "text-align: left;" do
              button_to "comment",js_comment_admin_post_path(post.id),remote: true
            end
            div class: "spacing", style: "height: 20px;"
          end
        end
      end
    end
  end
end
#|
