# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:alice_report)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'

    assert_text 'Sinatraの勉強'
    assert_text '難しかった～'
    assert_text 'alice'

    assert_text 'CSS初級'
    assert_text 'やっとできた～'
    assert_text 'bob'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '自作サービスに着手'
    fill_in '内容', with: 'がんばるぞ～'
    click_on '登録する'

    assert_text '日報が作成されました。'

    assert_text '自作サービスに着手'
    assert_text 'がんばるぞ～'
    assert_text 'alice'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: 'Sinatraの勉強を進める'
    fill_in '内容', with: '楽しくなってきた～'
    click_on '更新する'

    assert_text '日報が更新されました。'

    assert_text 'Sinatraの勉強を進める'
    assert_text '楽しくなってきた～'
    assert_text 'alice'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
    assert_no_text 'Sinatraの勉強'
  end
end
