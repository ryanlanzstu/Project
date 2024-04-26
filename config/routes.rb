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

   #Calendar routes
 root "calendar#index"
 get "calendar/month", to: 'calendar#month'
end



