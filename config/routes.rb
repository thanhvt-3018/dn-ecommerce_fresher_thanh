Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resource :carts

    namespace :admin do
      get "index"

      resources :products, only: %i(index update create destroy)
    end
  end
end
