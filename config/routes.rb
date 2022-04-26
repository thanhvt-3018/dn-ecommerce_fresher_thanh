Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"

    namespace :admin do
      get "index"
      get "/login", to: "sessions#new"
      post "/login", to: "sessions#create"
      delete "/logout", to: "sessions#destroy"
    end
  end
end
