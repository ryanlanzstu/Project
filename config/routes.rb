Rails.application.routes.draw do
  resources :tasks do
    member do
      put :sort
      patch :update_date
      patch :move
    end
  end

  resources :lists do
    member do
      put :sort
    end
  end

  root "home#index"
  get "calendar/month", to: 'calendar#month'

  devise_for :users
  resources :collegemodules, path: 'home_modules'
  get 'home/modules', to: 'home#modules', as: 'home_modules'
  resources :events
end
