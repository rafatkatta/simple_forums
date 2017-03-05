class User < ApplicationRecord
  # Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable,
       :recoverable, :rememberable, :registerable, :trackable
       #,:confirmable, :validatable
  belongs_to :user_level
  has_many :posts
  has_many :topics
  has_one  :forum

  delegate :level, to: :user_level
  delegate :description,to: :user_level

  def active_for_authentication?
    super && self.active?
  end

  def is_active?
    self.active
  end

  def inactive_message
    "Sorry, this account has been deactivated."
  end

  def full_name
    return "#{first_name} #{last_name}"
  end

end
