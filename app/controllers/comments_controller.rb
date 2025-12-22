class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comment added"
    else
      redirect_to @post, alert: "Comment cannot be empty"
    end
  end



  def show
    # @comment is already set by set_comment
  end

  
  def edit
    authorize_comment!
  end

  def update
    authorize_comment!

    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_comment!
    @comment.destroy
    redirect_to @post, notice: "Comment deleted"
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authorize_comment!
    unless current_user == @comment.user || current_user == @post.user
      redirect_to @post, alert: "Not authorized"
    end
  end
end
