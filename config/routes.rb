Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"

    namespace :admin do
      get "index"
    end
  end
end
