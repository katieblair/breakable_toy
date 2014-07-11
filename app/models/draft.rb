class Draft < ActiveRecord::Base
  validates :title, presence: true
  validates :restriction, presence: true
  validates :summary, presence: true
  validates :body, presence: true

  belongs_to :user
  belongs_to :genre
  has_many :critiques, dependent: :destroy
end
