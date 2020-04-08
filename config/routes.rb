Rails.application.routes.draw do
  root 'home/top'
  get 'home/about'
  get 'post/new'
  get 'post/index'
  get 'post/:id'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
