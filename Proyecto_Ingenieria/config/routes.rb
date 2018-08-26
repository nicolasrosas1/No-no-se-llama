Rails.application.routes.draw do
  get '/home', to: 'home#new'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users

  get '/new_material', to:'materials#new'
  get '/list_materials', to:'materials#list_materials'
  resources :materials

  get '/new_order', to:'orders#new'
  post '/add_material', to: 'orders#add_material'
  resources :orders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
