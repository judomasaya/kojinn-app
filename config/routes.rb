Rails.application.routes.draw do

  devise_for :users
  #ログイン機能の　gem deviseを利用する際にはアカウントを作成するためのUserモデルを新しく作成します。
  devise_for :installs
  root to: 'posts#index' #/にアクセスしたらこれでindex画面に飛ばす
  resources :posts do#下のをリファクタリングすると、postsだけで良くなる
  # only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :comments, only: [:create]
      collection do
        get 'search'
      end
  end
  # ルーティングをネストさせる一番の理由はアソシエーション先のレコードのidを
  # paramsに追加してコントローラーに送るためです。
  # 今回の実装だと、コメントと結びつく投稿（ぽすと）のidをparamsに追加しています。

  resources :users, only: :show #usersコントローラーを作成しこれを記述
end
  # 　マイページの詳細を見るやーつrails g controller users 忘れずに
  # これで、/users/:idのパスでアクセスした際にusers_controller.rbの
  # showアクションを呼ぶルーティングが設定できました。

  # 例えば
# resources :posts, except: :index
# exceptを使用するとindexのみ除外？という意味