class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true

  has_many :drafts
  has_many :critiques

  def is_member?(group)
    @membership = Membership.where(user: self, group: group)
    if !@membership.empty?
      true
    else
      false
    end
  end
end
