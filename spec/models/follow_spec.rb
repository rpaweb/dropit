require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:follower) {
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

  let(:followed) {
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

  it "is a valid following" do
    follow = follower.follow(followed)
    expect(follow).to be_valid
  end
end
