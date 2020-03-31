Rails.application.routes.draw do
  
  devise_for :users
  devise_for :installs
  root to: 'posts#index'
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :users, only: :show #usersコントローラーを作成　詳細見るやーつrails g controller users 忘れずに
end

# resources :posts, except: :index
# exceptを使用するとindex以外は網羅したぜ？という意味