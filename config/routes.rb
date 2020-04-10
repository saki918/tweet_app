Rails.application.routes.draw do
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
