class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic, autosave: true

  delegate :full_name, to: :user
  delegate :last_poster_id, to: :topic
  delegate :last_post_at, to: :topic

  after_commit :set_post_topic_data, on: [:create, :destroy]

  private

  def set_post_topic_data
    topic = Topic.find(topic_id)
    topic.update_attributes!(last_poster_id: user_id, last_post_at: DateTime.now)
  end

end
