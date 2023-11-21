Rails.application.routes.draw do

  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  devise_for :users

  root 'recipes#index'
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: %i[index show new create destroy]
end
