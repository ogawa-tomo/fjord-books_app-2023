# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'title should not be blank' do
    user = users(:alice)
    report = user.reports.build(title: '', content: 'fugafuga')
    assert report.invalid?
  end

  test 'content should not be blank' do
    user = users(:alice)
    report = user.reports.build(title: 'hogehoge', content: '')
    assert report.invalid?
  end

  test 'editable?' do
    alice = users(:alice)
    alice_report = reports(:alice_report)
    assert alice_report.editable?(alice)

    bob = users(:bob)
    assert_not alice_report.editable?(bob)
  end

  test 'created_on' do
    report = reports(:alice_report)
    assert_equal report.created_at.to_date, report.created_on
  end
end
