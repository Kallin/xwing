Rails.application.routes.draw do
  devise_for :users

  root to: "ships#index"

  # root "ships#index"
  
  resources :ships

  get '/collection', to: 'collections#show', as: 'collection'
  post '/collection/add_ship/:ship_id', to: 'collections#add_ship', as: 'collection_add_ship'
  post '/collection/remove_ship/:ship_id', to: 'collections#remove_ship', as: 'collection_remove_ship'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
