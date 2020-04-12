Rails.application.routes.draw do
  # create には :id を付けない。
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get 'users/index'
  # id のURLは生成される番号以外の物も含まれてしまうので、なるべく下に記述する。
  get 'users/:id' => "users#show"
  get 'users/:id/edit' => "users#edit"
  post "users/:id/update" => "users#update"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  get '/about' => "home#about"

  get 'post/new' => "post#new"
  get 'post/index' => "post#index"
  get 'post/:id' => 'post#show'
  get "post/:id/edit" => 'post#edit'
  # データベースで変更する物はpost
  post "post/:id/update" => "post#update"
  post 'post/:id/destroy' => 'post#destroy'
  post "post/create" => "post#create"
end
