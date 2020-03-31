class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end

# 今回の場合、マイページ作成で必要な情報はユーザー情報とログイン中のユーザーの投稿の2つです。
# それぞれを@userと@postsという変数に定義しましょう。

