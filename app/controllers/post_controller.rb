class PostController < ApplicationController
  def new
  end

  def index
    @posts = Post.all.order(created_at: :asc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.save

    redirect_to "/post/index"
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy

    redirect_to '/post/index'
  end

end
