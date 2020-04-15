class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[index show edit update]
  before_action :forbid_login_user, only: %i[new create login_form login]
  before_action :ensure_correct_user, only: [:edit, :update]

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
      image_name: "default_user.jpg",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
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
    # params[:***] ***はname属性で記述した名前を記入する。カラム名ではない
    if params[:image]
      # 画像のデータファイル名はデータベースに保存
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      # 画像保存の際はbinwriteを使用。readメソッドで画像データを取得
      # 画像データ自身はフォルダ内に保存する。
      File.binwrite("public/#{@user.image_name}", params[:image].read)
    end
    if @user.save
      flash[:notice] = 'ユーザー情報を編集しました'
      redirect_to "/users/#{@user.id}"
    else
      # ファイルのパスを指定
      render "users/edit"
    end
  end
  def login_form
    
  end

  def login
    # 入力内容と一致するユーザーを取得し、変数@userに代入してください
    # パスワードとEメールが一致しているユーザーを検索する。
    @user = User.find_by(email: params[:email], password: params[:password])
    # @userが存在するかどうかを判定するif文を作成してください
    if @user
      # 変数sessionに、ログインに成功したユーザーのidを代入してください
      # sessionにブラウザ上でユーザーの保存情報を保持させる。
      session[:user_id] = @user.id

      flash[:notice] = 'ログインしました'
      redirect_to '/post/index'
    else
      # @error_messageを定義してください
      # モデルのバリデーションに引っかかったわけではないので、エラーメッセージを自分で作成する必要がある。
      @error_message = 'メールアドレスまたはパスワードが間違っています'

      # @emailと@passwordを定義してください
      @email = params[:email]
      @password = params[:password]
      render 'users/login_form'
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/login"
  end

  def likes
    # 変数@userを定義してください
    @user = User.find_by(id: params[:id])

    # 変数@likesを定義してください
    @likes = Like.where(user_id: @user.id)
  end

  # もしログインユーザーとパラメータで受け取る数値が異なる場合
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = '権限がありません'
      redirect_to '/posts/index'
    end
  end

end
