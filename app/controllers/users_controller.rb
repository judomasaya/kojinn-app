class UsersController < ApplicationController
  def show
    # binding.pry
    @user = User.find(params[:id])
    # @posts = @user.posts
    @posts = @user.posts.page(params[:page]).per(3).order("created_at DESC")
  end
end


# マイページに必要な情報は
# ユーザー情報　@user = User.find(params[:id])
# ログイン中のユーザーの投稿　    @posts = @user.posts
# の2つ