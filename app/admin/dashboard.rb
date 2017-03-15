ActiveAdmin.register_page "Dashboard" do

  menu priority: 0, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default" do
      Forum.includes(topics: {posts: :user_comments}).order(:id).each do |forum|
        tabs do
          tab "Forums" do
            div class: "table" do
              div class: "tr" do
                div class: "th" do
                  forum.name
                end
                div class: "th" do
                  forum.description
                end
                div class: "th" do
                  forum.full_name
                end
                div class: "th", style: "float:right;width:100px;" do
                  button_to "Add topic",js_topic_admin_forum_path(forum.id), remote: true
                end
              end
            end
          end
        end
        div class: "Form_Topics",id: "topic_#{forum.id}"
        forum.topics.each do |topic|
          tabs do
            tab "Topics" do
              div class: "table" do
                div class: "tr" do
                  div class: "th" do
                    topic.name
                  end
                  div class: "th" do
                    topic.last_poster
                  end
                  div class: "th" do
                    topic.last_posted
                  end
                  div class: "th", style: "float:right;width:100px;" do
                    button_to "Add Post",js_post_admin_topic_path(topic.id),
                    remote: true
                  end
                end
              end
            end
          end
          div class: "Topic_Posts", id: "post_#{topic.id}"
          topic.posts.each do |post|
            tabs do
              tab "Posts" do
                  table_for post do
                    column post.full_name
                    column post.content
                    column post.posted
                  end
              end
            end
            tabs do
              tab "Comments" do
            post.user_comments.each do |user_comment|
                    table_for user_comment do
                      column user_comment.full_name
                      column user_comment.content
                    end
                  end
                end
              end
            div class: "Post_comments", id: "comment_post_#{post.id}", style: "text-align: left;" do
              button_to "comment",js_comment_admin_post_path(post.id), remote: true
            end
            div class: "spacing", style: "height: 20px;"
          end
        end
      end
    end
  end
end
#|
