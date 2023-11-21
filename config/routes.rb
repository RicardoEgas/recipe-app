Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root :to => 'foods#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [] do
    resources :foods, only: [:index, :show, :new, :create, :destroy]
    resources :recipes, only: [:index, :new, :create, :show, :destroy]
  end

  resources :recipes, only: [:index, :new, :create, :show, :update, :destroy] do
    resources :recipe_foods
  end

  resources :foods, only: [:index, :new, :create, :destroy]
end
