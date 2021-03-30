Rails.application.routes.draw do
  resources :categories
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products, only: :show do
    collection do
      get :search
    end
  end
  root to: "products#index"
end
