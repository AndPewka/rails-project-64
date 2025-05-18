require "test_helper"

class PostLikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test "guest cannot like a post" do
    post post_like_path(post_id: @post.id, locale: :en)
    assert_redirected_to new_user_session_path(locale: :en)
  end

  test "authenticated user can like a post" do
    sign_in @user
    delete post_like_path(post_id: @post.id, locale: :en)

    assert_difference("PostLike.count", 1) do
      post post_like_path(post_id: @post.id, locale: :en)
    end

    follow_redirect!
    assert_response :success
    assert_select "button", text: /#{I18n.t("post.unlike")}/
  end

  test "authenticated user cannot like the same post twice" do
    sign_in @user
    post post_like_path(post_id: @post.id, locale: :en)

    assert_no_difference("PostLike.count") do
      post post_like_path(post_id: @post.id, locale: :en)
    end

    follow_redirect!
    assert_response :success
    assert_select "button", text: /#{I18n.t("post.unlike")}/
  end

  test "authenticated user can unlike a liked post" do
    sign_in @user
    post post_like_path(post_id: @post.id, locale: :en)

    assert_difference("PostLike.count", -1) do
      delete post_like_path(post_id: @post.id, locale: :en)
    end

    follow_redirect!
    assert_response :success
    assert_select "button", text: /#{I18n.t("post.like")}/
  end

  test "unliking a post not liked by the user does nothing" do
    sign_in @user
    delete post_like_path(post_id: @post.id, locale: :en)

    assert_no_difference("PostLike.count") do
      delete post_like_path(post_id: @post.id, locale: :en)
    end

    follow_redirect!
    assert_response :success
    assert_select "button", text: /#{I18n.t("post.like")}/
  end
end
