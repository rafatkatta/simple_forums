class Forum < ApplicationRecord
  has_many :topics, :dependent => :destroy
  belongs_to :admin, class_name: "User"

  delegate :full_name, to: :admin
end
