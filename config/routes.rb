Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/farms", to: "farms#index"
  get "farms/new", to: "farms#new"
  post "/farms", to: "farms#create"
  get "/farms/:id", to: "farms#show"
  get "/farms/:id/edit", to: "farms#edit"
  patch "/farms/:id", to: "farms#update"
  get "/products", to: "products#index"
  get "/products/:id", to: "products#show"
  get "/farms/:farm_id/products", to: "farm_products#index"
  get "/farms/:id/products/new", to: "farm_products#new"
  post "/farms/:id/products", to: "farm_products#create"
  get "/products/:id/edit", to: "products#edit"
  patch "/products/:id", to: "products#update"
end
