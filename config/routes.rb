Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"

    devise_for :users

    resource :carts
    resources :orders
    resources :categories do
      get "/products", to: "home#index"
    end

    namespace :admin do
      get "index"

      resources :orders
      resources :products, only: %i(index update create destroy)
    end
  end
end
