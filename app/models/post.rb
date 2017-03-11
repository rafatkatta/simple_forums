class Post < ApplicationRecord
  belongs_to :poster, class_name: "User"
  belongs_to :topic, autosave: true

  has_many :user_comments

  delegate :full_name, to: :poster
  delegate :last_poster, to: :topic
  delegate :last_post_at, to: :topic

  def last_commenter
    self.user_comments.last.commenter
  end

  def last_commenter_full_name
    last_commenter.try(:full_name) || ""
  end

  def last_comment
    self.user_comments.last.created_at.to_s || ""
  end

  def posted
    created_at.to_s
  end

end
