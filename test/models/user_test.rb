# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name or email' do
    user = User.new(email: 'hoge@example.com', name: '')
    assert_equal 'hoge@example.com', user.name_or_email

    user.name = 'hoge'
    assert_equal 'hoge', user.name_or_email
  end
end
