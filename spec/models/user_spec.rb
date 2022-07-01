require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(
      email: "hola@dropit.xyz",
      password: "qwerty123",
      password_confirmation: "qwerty123"
    )
  }

  it "is valid" do
    expect(subject).to be_valid
  end

  it "is not valid without password" do
    subject.password = nil
    subject.password_confirmation = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with password and password_confirmation not matching" do
    subject.password = "qwerty123"
    subject.password_confirmation = "qwerty"
    expect(subject).to_not be_valid
  end

  it "is not valid with password length < 6 characters" do
    subject.password = "abc"
    subject.password_confirmation = "abc"
    expect(subject).to_not be_valid
  end

  it "is not valid with bad email format" do
    subject.email = "hola"
    expect(subject).to_not be_valid
  end
end
