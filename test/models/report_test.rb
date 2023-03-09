# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    user = User.new(name: 'hoge', email: 'hoge@example.com')
    report = user.reports.build()
    assert report.editable?(user)

    user2 = User.new(name: 'fuga', email: 'fuga@example.com')
    assert_not report.editable?(user2)
  end

  test 'created_on' do
    user = User.create!(name: 'hoge', email: 'hoge@example.com', password: 'password')
    report = user.reports.create!(title: 'hogehoge', content: 'fugafuga')
    assert_equal report.created_at.to_date, report.created_on
  end
end
