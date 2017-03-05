class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :forum
  has_many :posts, :dependent => :destroy

  delegate :full_name, to: :user

  def last_poster
    User.where(id: last_poster_id).last
  end

  def last_poster_full_name
    last_poster.try(:full_name) || ""
  end

  def poster
    User.where(id: user_id).last
  end

  def poster_full_neme
    poster.try(:full_name) || ""
  end

  def last_posted
    last_post_at.to_s || ""
  end

end
