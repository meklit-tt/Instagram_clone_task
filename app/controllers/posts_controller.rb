class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      @post.save
      PostMailer.post_mail(@post).deliver
      flash[:notice] = 'post created'
      redirect_to posts_path
    end
  end


  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_post
     @post = Post.find(params[:id])
  end

  def post_params
     params.require(:post).permit(:id,:image, :image_cache, :posts, :user_id, :name, :email)
  end
end
