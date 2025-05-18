class PostLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
   unless @post.post_likes.exists?(user: current_user)
      @post.post_likes.create!(user: current_user)
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    like = @post.post_likes.find_by(user: current_user)
    like&.destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
