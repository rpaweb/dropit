class Post < ApplicationRecord
  belongs_to        :user
  has_many          :comments,  dependent: :destroy
  has_one_attached  :image      ## Posts has now image attachments.
  is_impressionable             ## Attaching impressions to the post model.

  validates :title, :description,   presence: true

  validate :image_validation

  def image_validation
    if image.attached?
      if image.blob.byte_size > 1000000
        errors[:base] << 'Too big'
      elsif !image.blob.content_type.starts_with?('image/')
        errors[:base] << 'Wrong format'
      end
    end
  end

  # Parameterize the Posts' URL for SEO purposes.
  def to_param
    [id, title.parameterize].join("-")
  end
end
