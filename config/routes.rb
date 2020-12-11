Rails.application.routes.draw do
  devise_for :users
  resources :forums
  resources :games
  #All routes for home controller
  root 'home#home'
  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'
  get 'search', to: 'home#gb_search'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
