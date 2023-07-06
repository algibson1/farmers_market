Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/farms", to: "farms#index"
  get "/farms/:id", to: "farms#show"
end
