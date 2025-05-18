require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @parent_comment = post_comments(:with_comments)
  end

  test "unauthenticated user cannot create comment" do
    assert_no_difference("PostComment.count") do
      post post_comments_path(@post, locale: :en), params: {
        post_comment: { content: "Unauthorized comment" }
      }
    end

    assert_redirected_to new_user_session_path(locale: :en)
  end

  test "authenticated user can create comment" do
    sign_in @user

    assert_difference("PostComment.count", 1) do
      post post_comments_path(@post, locale: :en), params: {
        post_comment: { content: "Test comment" }
      }
    end

    assert_redirected_to post_path(@post, locale: :en)
    follow_redirect!
    assert_match "Test comment", response.body
  end

  test "authenticated user can create nested comment" do
    sign_in @user

    assert_difference("PostComment.count", 1) do
      post post_comments_path(@post, locale: :en), params: {
        post_comment: {
          content: "Nested comment",
          parent_id: @parent_comment.id
        }
      }
    end

    assert_redirected_to post_path(@post, locale: :en)
  end

  test "comment must have content" do
    sign_in @user

    assert_no_difference("PostComment.count") do
      post post_comments_path(@post, locale: :en), params: {
        post_comment: { content: "" }
      }
    end

    assert_redirected_to post_path(@post, locale: :en)
    follow_redirect!
    assert_match I18n.t("comments.failed"), response.body
  end

  test "other user cannot delete someone else's comment" do
    sign_in users(:two)

    assert_no_difference("PostComment.count") do
      delete post_comment_path(@post, post_comments(:one), locale: :en)
    end

    assert_redirected_to post_path(@post, locale: :en)
    follow_redirect!
    assert_match I18n.t("comments.forbidden"), response.body
  end
end
