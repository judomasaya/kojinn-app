class CommentsController < ApplicationController
  def create
    Comment.create(comment_params)
    # redirect_to "/"  # コメントと結びつく投稿の詳細画面に遷移する
    redirect_back(fallback_location: root_path)
    # 一つ前に戻る技発見
    # redirect_to "/posts/#{comment.post.id}"#これ使用したいがエラー出る
    # post_comments POST   /posts/:post_id/comments(.:format)                                                       comments#create


    # tweetsコントローラのshowアクションを実行するにはツイートのidが必要です。
    # そのため、ストロングパラメーターを用いた上で変数commentに代入します。
    # リダイレクト先の指定には、アソシエーションを利用してcommentと結びつくツイートのidを記述しています。
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
# user_idカラムには、ログインしているユーザーのidとなるcurrent_user.idを保存し、
# post_idカラムは、paramsで渡されるようにするので、params[:post_id]として保存しています。

