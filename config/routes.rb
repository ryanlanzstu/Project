Rails.application.routes.draw do
  # Sort action for tasks
  resources :tasks do
  member do
    put :sort
  end
end

  #Sort action for lists
  resources :lists do
    member do
      put :sort
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end