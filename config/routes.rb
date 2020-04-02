Rails.application.routes.draw do
  
  devise_for :users
  devise_for :installs
  root to: 'posts#index'#/にアクセスしたらこれでindex画面に飛ばす
  resources :posts#下のをリファクタリングする、postsだけで良くなる
  # only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :users, only: :show #usersコントローラーを作成しこれを記述
  # 　マイページの詳細を見るやーつrails g controller users 忘れずに
  # これで、/users/:idのパスでアクセスした際にusers_controller.rbの
  # showアクションを呼ぶルーティングが設定できました。
end

# resources :posts, except: :index
# exceptを使用するとindex以外は網羅したぜ？という意味