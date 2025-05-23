# frozen_string_literal: true

class PostsController < ApplicationController
  # layout 'application'
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.includes(:creator, :category).order(created_at: :desc)
  end

  def show
    @post
  end

  def new
    @post = Post.new
  end

  def edit
    @post
  end

  def create
    @post = current_user.created_posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('post.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('post.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: t('post.destroyed')
  end

  private

  def set_post
    @post = Post.find(params[:id])

    return unless %w[edit update destroy].include?(action_name) && @post.creator != current_user

    redirect_to root_path, alert: t('post.forbidden')
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
