class UserComment < ApplicationRecord
  belongs_to :commenter, class_name: "User"
  belongs_to :post

  delegate :full_name, to: :commenter

  def post_content
    self.post.try(:content)
  end

end
