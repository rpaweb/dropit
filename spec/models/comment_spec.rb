require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user1) {
    User.create(
      email: "hola@dropit.xyz",
      password: "qwerty123",
      password_confirmation: "qwerty123",
      profile_attributes: {
        name: "Drop",
        lastname: "It"
      }
    )
  }

  let(:user2) {
    User.create(
      email: "chao@dropit.xyz",
      password: "qwerty123",
      password_confirmation: "qwerty123",
      profile_attributes: {
        name: "It",
        lastname: "Drop"
      }
    )
  }

  let(:post) {
    Post.create(
      title: "Post 1",
      description: "This is a post.",
      user_id: user1.id
    )
  }

  subject {
    described_class.new(
      description: "This is a comment.",
      post_id: post.id,
      user_id: user2.id
    )
  }

  it "is a valid" do
    expect(subject).to be_valid
  end
end
