class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      # ここに直接データを書き込めば、初期設定として登録できる。
      image_name: "default_user.jpg"
    )
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      # URLを指定
      redirect_to "/users/#{@user.id}"
    else
      render action: "new"
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    # もし画像が更新されたときのif文分岐
    if params[:image]
      # 画像のデータファイル名はデータベースに保存
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      # 画像保存の際はbinwriteを使用。readメソッドで画像データを取得
      # 画像データ自身はフォルダ内に保存する。
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice] = 'ユーザー情報を編集しました'
      redirect_to "/users/#{@user.id}"
    else
      # ファイルのパスを指定
      render "users/edit"
    end
  end
end
