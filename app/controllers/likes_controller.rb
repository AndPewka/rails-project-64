# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_like, only: :destroy

  def create
    @post.likes.find_or_create_by!(user: current_user)
    redirect_back fallback_location: root_path
  end

  def destroy
    @like.destroy!
    redirect_back fallback_location: root_path
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_like
    @like = @post.likes.find(params[:id])
    return if @like.user == current_user

    redirect_back(fallback_location: root_path, alert: t('likes.forbidden'))
  end
end
