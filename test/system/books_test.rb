# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:cherry_book)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'

    assert_text 'プロを目指す人のためのRuby入門'
    assert_text '名著ですね！！！'
    assert_text 'jnchito'

    assert_text '論理哲学論考'
    assert_text '歴史的名著'
    assert_text 'Ludwig Wittgenstein'
  end

  test 'should create book' do
    visit books_url
    click_on '本の新規作成'

    assert_selector 'h1', text: '本の新規作成'

    fill_in 'タイトル', with: 'Ruby超入門'
    fill_in 'メモ', with: 'わかりやす～い！'
    fill_in '著者', with: 'igaiga'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_selector 'h1', text: '本の詳細'

    assert_text 'Ruby超入門'
    assert_text 'わかりやす～い！'
    assert_text 'igaiga'
  end

  test 'should update Book' do
    visit book_url(@book)
    click_on 'この本を編集'

    assert_selector 'h1', text: '本の編集'

    fill_in 'タイトル', with: 'プロを目指す人のためのRuby入門 第2版'
    fill_in 'メモ', with: 'さらに名著になった'
    fill_in '著者', with: '伊藤淳一'
    click_on '更新する'

    assert_text '本が更新されました'
    assert_selector 'h1', text: '本の詳細'

    assert_text 'プロを目指す人のためのRuby入門 第2版'
    assert_text 'さらに名著になった'
    assert_text '伊藤淳一'
  end

  test 'should destroy Book' do
    visit book_url(@book)
    click_on 'この本を削除'

    assert_text '本が削除されました。'
    assert_selector 'h1', text: '本の一覧'
    assert_no_text 'プロを目指す人のためのRuby入門'
  end
end
