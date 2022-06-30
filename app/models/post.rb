class Post < ApplicationRecord
  belongs_to        :user
  has_many          :comments,  dependent: :destroy
  has_one_attached  :image      ## Posts has now image attachments.
  is_impressionable             ## Attaching impressions to the post model.

  validates :title, :description,   presence: true

  # Parameterize the Posts' URL for SEO purposes.
  def to_param
    [id, title.parameterize].join("-")
  end
end
