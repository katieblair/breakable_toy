class Group < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :moderator, class_name: "User"#, foreign_key: 'user_id'

  has_many :memberships
  has_many :members, through: :memberships, class_name: "User"
  has_many :drafts
end
