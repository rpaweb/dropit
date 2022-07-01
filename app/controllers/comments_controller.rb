class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post

  def new
    @comment = @post.comments.build
  end

  def edit; end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "Comment was succesfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def get_post
    @post = Post.find params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:description, :post_id, :user_id)
  end
end