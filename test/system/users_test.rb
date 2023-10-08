# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit users_url

    assert_selector 'h1', text: 'Users'
  end

  test 'user can create an account' do
    visit new_user_path

    fill_in 'user_name',	with: 'Homura'
    fill_in 'user_debt',	with: 2
    click_button 'Create User'

    assert_text 'User created'
  end
end
