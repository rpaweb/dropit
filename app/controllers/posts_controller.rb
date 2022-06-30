class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_post, only: %i[ show edit update destroy ]
  impressionist actions: [ :show ]  ## Adding the impressions attach only to post view.

  def index
    # Posts now appear in desc order to always view first the last one uploaded.
    @posts = Post.order(created_at: :desc).all
  end

  def show
    # Identification of the users who saw each post (unique views), then shown them in the view.
    # The unique views are only avaliable to see for the owner of the post.
    # In the unique views counter are not considered the owner of the post.
    @seen_by = []
    @post.impressions.each do |impression|
      post_watcher = User.find(impression.user_id)
      @seen_by |= [post_watcher] if post_watcher != @post.user
    end
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def bulk; end

  # Upload posts massively from CSV
  def upload
    require 'csv'
    require 'open-uri'

    post_errors = Array.new

    CSV.parse(File.read(params[:file]), { headers: true, col_sep: ";" }) do |row|
      post = Post.new title: row['title'], description: row['description']
      post.user = current_user
      post.save
      post_errors << post.errors if post.errors.any?
    end

    respond_to do |format|
      if post_errors.empty?
        format.html { redirect_to root_path, notice: "Bulk upload finished successfully." }
      else
        format.html { redirect_to root_path, alert: "Bulk upload finished with errors and may not has uploaded all posts." }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :image, :user_id)  ## Added image as a required param.
    end
end
