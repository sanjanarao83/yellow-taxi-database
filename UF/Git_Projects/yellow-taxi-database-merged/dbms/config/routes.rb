Rails.application.routes.draw do
  get 'employees/about'
  get 'employees/contact'
  get 'employees/login'

  #post 'fares' => 'fares#index'
   post 'fares' => 'fares#index'
   post "/employees/login" => "employees#login_employee"

  resources :fares
  resources :trips
  resources :employees
  resources :trip_data
  resources :fare_data
  root 'employees#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
