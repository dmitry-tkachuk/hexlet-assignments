class Posts::CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[ edit update destroy ]
  
  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      render 'posts/show'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: 'Comment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment was successfully destroyed.'
  end
  
  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def set_comment
    @comment = PostComment.find(params[:id])
  end
  
  def comment_params
    params.require(:post_comment).permit(:content)
  end
end
