class Critique < ActiveRecord::Base
  validates :comment, presence: true
  validates :draft, presence: true

  belongs_to :draft
  belongs_to :user
end
