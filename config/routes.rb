Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users

  resources :home, only: [:index] do
    get :evaluate_wanikani, on: :collection
  end
end
