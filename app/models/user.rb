class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise      :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable,
              :omniauthable, omniauth_providers: [:google_oauth2]

  has_one                       :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  
  has_many    :given_follows,    class_name: 'Follow',        foreign_key: 'follower_id', dependent: :destroy   ## returns an array of follows a user gave to someone else
  has_many    :following,       through: :given_follows,     source: :followed                                 ## returns an array of other users who the user has followed
  has_many    :received_follows, class_name: 'Follow',        foreign_key: 'followed_id', dependent: :destroy   ## Will return an array of follows for the given user instance
  has_many    :followers,        through: :received_follows,  source: :follower                                 ## Will return an array of users who follow the user instance

  has_many    :posts,     dependent: :destroy
  has_many    :comments,  dependent: :destroy

  validates   :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Follows a user
  def follow(other_user)
    given_follows.create(followed_id: other_user.id)
  end

  # Unfollows a user
  def unfollow(other_user)
    given_follows.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user
  def following?(other_user)
    following.include?(other_user)
  end

  # Methods to deal with callback data of omniauth (user)
  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # Methods to deal with callback data of omniauth (profile)
  def self.create_profile_from_provider_data(user, provider_data)
    Profile.where(user_id: user.id).first_or_create do |profile|
      profile.name = provider_data.info.first_name
      profile.lastname = provider_data.info.last_name
      profile.user_id = user.id
    end
  end
end
