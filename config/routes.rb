Rails.application.routes.draw do
  devise_for :users
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

   #Calendar routes
 root "events#index"
 get "calendar/month", to: 'calendar#month'
end



