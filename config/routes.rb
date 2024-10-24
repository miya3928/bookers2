Rails.application.routes.draw do
  devise_for :users
  
  # ルートの設定
  root to: "homes#top"
  get "home/about", to: "homes#about"
  
  # 書籍のルーティングを直接設定
  resources :books  # 上記の行でonlyオプションを用いてcreate以外のアクションも指定可能
  # ユーザーの一覧、詳細、編集、更新のルーティングを設定
  resources :users, only: [:index, :show, :edit, :update, :new, :create]
end