Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'

  resources :users do
    collection do
      get :dashboard
    end
  end
  resources :restaurants
  resources :groups
end
