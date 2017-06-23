Rails.application.routes.draw do
  root "blog#index"
  get "blog/index"
  resources :posts
end
