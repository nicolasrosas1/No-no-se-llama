Rails.application.routes.draw do

  get '/new_material', to:'materials#new'
  resources :materials

  get '/list_materials', to:'materials#list_materials'
  resources :materials
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
