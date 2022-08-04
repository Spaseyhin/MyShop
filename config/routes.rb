Rails.application.routes.draw do
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
root 'products#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
