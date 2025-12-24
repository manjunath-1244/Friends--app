class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :destroy]

  def index
    # binding.pry
    @posts = Post.all
    @count = Post.count
    
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post=Post.find(params[:id])

    unless current_user == @post.user || current_user.admin?
      return redirect_to posts_path, alert: "Not authorized"
    end

    @post.destroy
    redirect_to posts_path, notice: "Post deleted"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
