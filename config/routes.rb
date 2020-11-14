Rails.application.routes.draw do
  resources :dresseds
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :linebots, only: %i[create]
  get '/dresseds%22;', to: 'dresseds#create'
end
