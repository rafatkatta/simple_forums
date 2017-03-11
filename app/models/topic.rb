class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :forum
  has_many :posts, dependent: :destroy

  delegate :full_name, to: :user

  def last_poster
    if !posts.last.blank?
      posts.last.poster.full_name
    else
      full_name
    end
  end

  def last_posted
    if !posts.last.blank?
      posts.last.created_at.to_s
    else
      created_at.to_s
    end    
  end

end
