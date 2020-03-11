class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, except: [:index, :create, :new]

  def index
    @posts = Post.for_user(current_user)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
     redirect_to @post
    else
     render 'edit'
    end
  end

  def show
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def create
    #render plain: params[:post].inspect
    @post = Post.new(post_params.merge(user_id: current_user.id))
   if @post.save
     redirect_to @post
   else
     render 'new'
   end
  end

  private

  def set_post
    @post = Post.for_user(current_user).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
