Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get "/merchants/most_revenue", to: "revenues#index"
      get "/merchants/revenue", to: "revenues#show"

      get "/merchants/find", to: "merchants#show"
      get "/merchants/find_all", to: "merchants#index"
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      get "/customers/find", to: "customers#show"
      get "/customers/find_all", to: "customers#index"
      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end

      get "/items/find", to: "items#show"
      get "/items/find_all", to: "items#index"
      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index]
        get "/merchant", to: "merchants#show"
      end

      resources :invoices, only: [:index, :show]
    end
  end
end
