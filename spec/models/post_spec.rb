require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) {
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

  subject {
    described_class.new(
      title: "Post 1",
      description: "Post description.",
      user_id: user.id
    )
  }

  it "is a valid" do
    expect(subject).to be_valid
  end

  it "is not valid without title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end
end
