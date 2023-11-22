Rails.application.routes.draw do
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  devise_for :users
  get '/recipes/:recipe_id/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
  devise_scope :user do
    authenticated :user do
      root to: 'foods#index', as: :authenticated_root
    end
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [] do
    resources :foods, only: %i[index show new create destroy]
    resources :recipes, only: %i[index new create show destroy]
  end

  resources :recipes, only: %i[index new create show update destroy] do
    resources :recipe_foods
    member do
      patch :toggle_public
    end
  end

  resources :public_recipes, only: [:index]
  resources :foods, only: %i[index new create destroy]
end
