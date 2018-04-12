Rails.application.routes.draw do
  resources :fares
  resources :trips
  resources :trip_data
  resources :fare_data
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
