# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
    assert_template :index
  end

  test 'should create a user succesfully' do
    assert_difference('User.count', 1) do
      post :create, params: { user: { name: 'Homura', debt: 2 } }
    end

    assert_redirected_to user_path(assigns(:user))
    assert_equal 'User created', flash[:success]
  end

  test 'should not create a user with invalid data' do
    assert_no_difference('User.count') do
      post :create, params: { user: { name: '', debt: 0 } }
    end

    assert_equal 'User invalid', flash[:error]
    assert_template :new
  end
end
