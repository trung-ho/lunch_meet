Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'

  resources :users do
    collection do
      get :dashboard
      get :select_preferences
      patch :set_preferences
    end
  end
  resources :restaurants
  resources :groups do
    resources :events
    resources :members
  end
end
