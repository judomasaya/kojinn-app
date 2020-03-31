class PostsController < ApplicationController
  def index
    # @post = Post.find(1)  # 1番目のレコードを@postに代入しviewへ写す
    @posts = Post.all #全てのレコードを@postsに代入 複数データの為、post→postsへ
    # @posts = Post.includes(:user) #includesを使用することによりn1問題の解消に。これをつけるだけでpostsテーブルのレコードを取得する段階で関連するusersテーブルのレコードも一度に取得することができます。
  end

  def new
    @post = Post.new
    # redirect_to root_path

  end
  
 
  def create
    # binding.pry
    # Post.create() #ActiveRecordのメソッドの一種 ()には、実際にPostテーブルに登録したいデータを記載します。
    # Post.create(content: params[:content]) #左側がカラム名（contentカラム）、右側がparamsとして送られて来たデータを表現　ただこれは正しい表記ではないので下に記載
    Post.create(post_params) #post_paramsってなんやねん　下へ
    @posts = Post.includes(:user)

    # @posts = Post.all
    # redirect_to root_path
    # リダイレクトさせるパスは、Prefixと_pathを用いて、ルートパスを指定しています。
  end

  def show
    @post = Post.find(params[:id])
    
    # 3がみたい！ルーティング設定し、routesで見るとidがついてる。そこに３のデータが入っている。
    # だからparams idの中には３が入ってる。postfindはレコードね
   end
   def edit
    @post = Post.find(params[:id])
   end

   def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path

  end



  private
  def post_params
    params.require(:post).permit(:title, :content, :age, :name, :allergy, :kusuri).merge(user_id: current_user.id)#postモデルでストロングがcontent.title.ageなどのカラムだけしか受け取らん！という意味、うえの(post_params)の答え。カレントはログイン中のidを取得。mergeは前後の情報を合体
  end
end
