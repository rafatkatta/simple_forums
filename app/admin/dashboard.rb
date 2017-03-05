ActiveAdmin.register_page "Dashboard" do

  menu priority: 0, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default" do
      tabs do
        tab "Forums" do
          Forum.order(id: :desc).each do |forum|
            table_for forum do
              column forum.name
              column forum.description
              column forum.full_name
            end
            tabs do
              tab "Topics" do
                forum.topics.each do |topic|
                  table_for topic do
                    column topic.name
                    column topic.last_poster_full_name
                    column topic.last_posted
                  end
                  tabs do
                    tab "Posts" do
                      topic.posts.each do |post|
                        table_for post do
                          column post.full_name
                          column post.content
                        end
                        div id: "comment_topic_#{topic.id}" do
                          button_to "comment",js_comment_admin_topic_path(topic.id), remote: true
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
