class Profile < ApplicationRecord
  belongs_to  :user

  has_one_attached :avatar, dependent: :destroy

  validates :name, :lastname, presence: true
  validates :user_id, uniqueness: { message: "has already a profile created." }

  validate :avatar_validation

  def avatar_validation
    if avatar.attached?
      if avatar.blob.byte_size > 1000000
        errors[:base] << 'Too big'
      elsif !avatar.blob.content_type.starts_with?('image/')
        errors[:base] << 'Wrong format'
      end
    end
  end
end
