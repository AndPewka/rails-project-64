# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: t('comments.created')
    else
      redirect_to post_path(@post), alert: t('comments.failed')
    end
  end

  def destroy
    @comment = PostComment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to post_path(@comment.post), notice: t('comments.deleted')
    else
      redirect_to post_path(@comment.post), alert: t('comments.forbidden')
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
