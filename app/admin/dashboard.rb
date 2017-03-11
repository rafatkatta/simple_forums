ActiveAdmin.register_page "Dashboard" do

  menu priority: 0, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default" do
      tabs do
        tab "Forums" do
          Forum.includes(topics: {posts: :user_comments}).order(:id).each do |forum|
            table_for forum do
              column forum.name
              column forum.description
              column forum.full_name
              column "#{forum.id}"
              column button_to "Add topic",js_topic_admin_forum_path(forum.id), remote: true
            end
            tabs do
              tab "Topics" do
                div id: "topic_#{forum.id}"
                forum.topics.each do |topic|
                  table_for topic do
                    column topic.name
                    column topic.last_poster
                    column topic.last_posted
                    column button_to "Add Post",js_post_admin_topic_path(topic.id), remote: true
                  end
                  tabs do
                    tab "Posts" do
                      div id: "post_#{topic.id}"
                      topic.posts.each do |post|
                        table_for post do
                          column post.full_name
                          column post.content
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
                        div id: "comment_post_#{post.id}" do
                          button_to "comment",js_comment_admin_post_path(post.id), remote: true
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
#t.column("Assigned To") { |task| task.admin_user.email }
#|t|
