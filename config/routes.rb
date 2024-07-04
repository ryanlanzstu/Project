Rails.application.routes.draw do
  # Sort action for tasks
  resources :tasks do
    member do
      put :sort
    end
  end

  # Sort action for lists
  resources :lists do
    member do
      put :sort
    end
  end

  # Calendar routes
  root "home#index"  # Choose either "home#index" or "calendar#index"
  get "calendar/month", to: 'calendar#month'

  devise_for :users
  resources :collegemodules, path: 'home_modules'
  get 'home/modules', to: 'home#modules', as: 'home_modules'
  get 'home/calendar', to: 'home#calendar', as: 'home_calendar'
  resources :events
end
