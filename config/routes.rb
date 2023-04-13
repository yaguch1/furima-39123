Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :users , only: [:new, :create] do
  end
  resources :items , only: [:index, :new, :create, :show]  do
  end
end
