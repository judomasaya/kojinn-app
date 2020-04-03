class CommentsController < ApplicationController
  def create
    Comment.create(comment_params)
    redirect_to "/posts/#{comment.post.id}"  # コメントと結びつく投稿の詳細画面に遷移する

  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end

# user_idカラムには、ログインしているユーザーのidとなるcurrent_user.idを保存し、
# post_idカラムは、paramsで渡されるようにするので、params[:post_id]として保存しています。

