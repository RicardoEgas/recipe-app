Rails.application.routes.draw do
  devise_for :users

  root 'recipes#index'
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: %i[index show new create]
end
