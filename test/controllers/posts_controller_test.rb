# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
    @category = categories(:one)
    @post = posts(:one)
  end

  test 'unauthorized user sees sign in button text with locale' do
    get root_path
    assert_response :success

    assert_select 'a', text: I18n.t('ui.sign_in')
  end

  test 'authorized user sees sign out button' do
    sign_in @user
    get root_path

    assert_response :success
    assert_select 'button', text: I18n.t('ui.sign_out')
  end

  test 'authorized user can create a post' do
    sign_in @user

    assert_difference('Post.count', 1) do
      post posts_path, params: {
        post: {
          title: 'Create post',
          body: 'x' * 200,
          category_id: @category.id
        }
      }
    end

    assert_redirected_to post_path(Post.last)
    follow_redirect!
    assert_response :success
    assert_match 'Create post', response.body
  end

  test 'authorized user can update a post' do
    sign_in @user

    patch post_path(@post), params: {
      post: {
        title: 'Update title',
        body: 'x' * 200,
        category_id: @category.id
      }
    }

    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_response :success
    assert_match 'Update title', response.body
  end

  test 'authorized user can delete a post' do
    sign_in @user

    assert_difference('Post.count', -1) do
      delete post_path(@post)
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end

  test 'unauthorized user cannot access edit post' do
    get edit_post_path(@post)

    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_response :success
    assert_match I18n.t('devise.failure.unauthenticated'), response.body
  end

  test "other user cannot edit someone else's post" do
    sign_in @other_user
    get edit_post_path(@post)

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_select 'div', text: I18n.t('post.forbidden')
  end
end
