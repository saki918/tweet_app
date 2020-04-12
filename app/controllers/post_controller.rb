class PostController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    # orderメソッドで一覧の並び替え。:ascだと古いものから新しいものに並べ替えられる。
    # :desc で新しいものから順に並べ替え。
    @posts = Post.all.order(created_at: :asc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.new(content: params[:content])
    if @post.save
      flash[:notice] = '投稿を作成しました'
      redirect_to('/post/index')
    else
      render ("post/new")
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = '投稿を編集しました'
      redirect_to "/post/index"
    else
      render "post/edit"
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to '/post/index'
  end

end
