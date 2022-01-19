Rails.application.routes.draw do
  #get 'api/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/api", to: "api#index"
  get "/resultado", to: "api#resultado"
  # Defines the root path route ("/")
  # root "articles#index"
end
