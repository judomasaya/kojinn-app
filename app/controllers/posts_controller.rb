class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit]
  before_action :move_to_index, except: [:index, :show, :search]
  # indexアクションにアクセスした時、indexアクションへのリダイレクトを繰り返し無限ループが起こるので、
  # except:を付け加えます。
  # また、詳細ページへはログインする必要はないものとするために
  # except: [:index, :show]としています。
  # 未ログイン状態にトップページへリダイレクトされてしまうことを回避するため、before_actionのexceptオプションに:searchを追加しています。

  # 42~44行




  # 一覧表示ページを表示するリクエストに対応して動く
  def index
    # @post = Post.find(1)  # 1番目のレコードを@postに代入しviewへ写す
    # @posts = Post.all
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(3)
    #全てのレコードを@postsに代入 複数データの為、post→postsへ
    # @posts = Post.includes(:user) #includesを使用することによりn1問題の解消に。
#     これをつけるだけでpostsテーブルのレコードを取得する段階で関連するusersテーブルのレコードも一度に取得することができます。
#     処理が速くなります。
# テーブルのレコード数が多くなるほど処理速度の差が大きくなるので、アソシエーションを組んだ際は必ずincludesメソッドを利用して対策しましょう。
  end

# 新規投稿ページを表示するリクエストに対応して動く
  def new
    @post = Post.new
  end

# データの投稿を行うリクエストに対応して動く
  def create
    # binding.pry
    # Post.create()の()には、実際にPostテーブルに登録したいデータを記載します。
    # Post.create(content: params[:content]) #左側がカラム名（contentカラム）
    # 右側がparamsとして送られて来たデータを表現　ただこれは正しい表記ではないので下に記載
    Post.create(post_params) #post_paramsってなんやねん　下へ
    # @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)

    # @posts = Post.page(params[:page]).per(5)
    # orderメソッドの引数として("created_at DESC")を足すだけで、レコードは逆順に並び替えられます。
    # kaminariによってリクエストの際paramsの中にpageというキーが追加されています。
    # その値がビューで指定したページ番号となるため、pageの引数はparams[:page]となります。


    # createアクションはフォームで送られてきた情報を元に、レコードを保存します。
    # ストロングパラメーターも忘れずに設定しましょう。
    # @posts = Post.all
    redirect_to root_path
    # リダイレクトさせるパスは、Prefixと_pathを用いて、ルートパスを指定しています。
  end

  # 個別詳細ページを表示するリクエストに対応して動く
  def show
  @comment = Comment.new
  @comments = @post.comments.includes(:user)
  # posts/show.html.erbでform_withを使用して、comments#createにアクション先を飛ばしたいので、
  # @comment = Comment.newとインスタンス生成をしないといけません。
  # ビューでは誰のコメントかを明らかにするためアソシを使ってユーザーのレコードを取得
  # その時に「N+1問題」が発生してしまうので、includesメソッド使用
# では、コントローラーであるpostsについて投稿されたコメントの全レコードを取得することができたので、これらをビューで表示しましょう。
  end

  def search
  @posts = Post.search(params[:keyword])
  end

  # 投稿編集ページを表示するリクエストに対応して動く
   def edit
    # @post = Post.find(params[:id])
    # params[:id]は元々レコードのIDが入っていたので、
    # IDに該当するレコードの全ての情報をテーブルから取得し編集をする
    # @postには編集するブログの情報が入るようになっています。
   end

  #  データの編集を行うリクエストに対応して動く
   def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  # データの削除を行うリクエストに対応して動く
  def destroy
    post = Post.find(params[:id])
    post.destroy
    # redirect_to root_path
  end

  def model_name
  end



  private
  def post_params
    params.require(:post).permit(:name, :nickname, :title, :onset, :sex, :asthma, :age, :allergy, :kusuri, :image).merge(user_id: current_user.id)
    #  うえの(post_params)の答え。カレントはログイン中のidを取得できる。mergeは前後の情報を合体
    # 投稿を保存する際、name、image、textというビューから送られてくる情報に加えて、user_idカラムにログイン中のユーザーのidを保存しなければいけません。
    # そのため、2つのハッシュを統合する時に使うmergeメソッドを利用して、user_idを統合しましょう。
    # user_idは、ログイン中のユーザーidが必要なため、current_user.idと記述することで取得が可能
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in? #ユーザーがログインしていない時にはindexアクションを実行する
  end

end








