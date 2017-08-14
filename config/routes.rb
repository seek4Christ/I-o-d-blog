Rails.application.routes.draw do

  devise_for :users
  get 'articles/about'
  get 'articles/contact'
  root to: 'articles#index'
  scope "(:locale)", locale: /en|fr|zh/ do
  resources :articles
    resources :comments
  end
    resources :tags
    mount ActionCable.server => '/cable'
  #resources :comments For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
