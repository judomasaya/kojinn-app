class PostsController < ApplicationController

  # before_action :set_post, only: [:edit, :show ]
  before_action :move_to_index, except: [:index, :show, :search]
  # indexアクションにアクセスした時、indexアクションへのリダイレクトを繰り返し無限ループが起こるので、
  # except: :indexを付け加えます。
  # また、詳細ページへはログインする必要はないものとするために
  # except: [:index, :show]としています。

  # 42~44行


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
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)

    # @posts = Post.page(params[:page]).per(5)
    # orderメソッドの引数として("created_at DESC")を足すだけで、レコードは逆順に並び替えられます。
    # kaminariによってリクエストの際paramsの中にpageというキーが追加されています。
    # その値がビューで指定したページ番号となるため、pageの引数はparams[:page]となります。


    # createアクションはフォームで送られてきた情報を元に、レコードを保存します。
    # ストロングパラメーターも忘れずに設定しましょう。
    # @posts = Post.all
    # redirect_to root_path
    # リダイレクトさせるパスは、Prefixと_pathを用いて、ルートパスを指定しています。
  end

  def show
    @post = Post.find(params[:id])

    # 3がみたい！ルーティング設定し、routesで見るとidがついてる。そこに３のデータが入っている。
    # だからparams idの中には３が入ってる。postfindはレコードね
   end

   def search
    @posts = Post.search(params[:keyword])
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
    # redirect_to root_path

  end



  private
  def post_params
    params.require(:post).permit(:title, :content, :age, :name, :allergy, :kusuri, :image).merge(user_id: current_user.id)#postモデルでストロングがcontent.title.ageなどのカラムだけしか受け取らん！という意味、うえの(post_params)の答え。カレントはログイン中のidを取得できる。mergeは前後の情報を合体
    # 投稿を保存する際、name、image、textというビューから送られてくる情報に加えて、user_idカラムにログイン中のユーザーのidを保存しなければいけません。
    # そのため、2つのハッシュを統合する時に使うmergeメソッドを利用して、user_idを統合しましょう。
  end

  # def set_post
  #   @post = post.find(params[:id])
  # end

  def move_to_index
    redirect_to action: :index unless user_signed_in? #ユーザーがログインしていない時にはindexアクションを実行する
  end

end








