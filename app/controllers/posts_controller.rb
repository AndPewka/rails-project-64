class PostsController < ApplicationController
  # layout 'application'
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.includes(:user, :category).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t("post.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t("post.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: t("post.destroyed")
  end

  private

  def set_post
    @post = Post.find(params[:id])

    if %w[edit update destroy].include?(action_name) && @post.user != current_user
      redirect_to root_path, alert: t("post.forbidden")
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
