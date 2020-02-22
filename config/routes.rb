Rails.application.routes.draw do
  get 'cse_class/index'
  root 'cse_class#index'
  resources :cse_class
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
