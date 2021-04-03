Rails.application.routes.draw do
  get 'cart/show'
  resources :categories
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products, only: :show do
    collection do
      get :search
    end
  end
  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  get "carts/:id" => "carts#show", as: "cart"
  delete "carts/:id" => "carts#destroy"

  post "cart_products/:id/add" => "cart_products#add_quantity", as: "cart_product_add"
  post "cart_products/:id/reduce" => "cart_products#reduce_quantity", as: "cart_product_reduce"
  post "cart_products" => "cart_products#create"
  get "cart_products/:id" => "cart_products#show", as: "cart_product"
  delete "cart_products/:id" => "cart_products#destroy"

  root to: "products#index"
end
