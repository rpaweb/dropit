class Profile < ApplicationRecord
  belongs_to  :user

  has_one_attached :avatar, dependent: :destroy

  validates :name, :lastname, presence: true
  validates :user_id, uniqueness: { message: "has already a profile created." }
end
