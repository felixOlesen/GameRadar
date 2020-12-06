Rails.application.routes.draw do
  resources :forums
  resources :games
  root 'home#home'
  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'
  get 'test', to: 'home#gb_search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
