# test/models/user_test.rb
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'john@example.com', encrypted_password: 'abcdefghijk')
  end

  test 'valid user' do
    assert @user.valid?
  end
end