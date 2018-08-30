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
  get '/list_orders', to:'orders#list_orders'
  get '/orders/:id', to: 'orders#show', as: :orders_show
  post '/add_material', to: 'orders#add_material'
  resources :orders

  get '/new_warehouse', to:'warehouses#new'
  get '/list_warehouses', to:'warehouses#list_warehouses'
  resources :warehouses

  post '/cotizar/:id', to:"orders#cotizar", as: :cotizar
  post '/form_presupuesto/:id', to: "orders#presupuestonew", as: :presupuestonew
  post '/presupuesto/:id', to: "orders#presupuesto", as: :presupuesto
  get '/presupuestos', to: "orders#getpresupuestos"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
