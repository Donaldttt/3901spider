Rails.application.routes.draw do
  get 'cse_class/index'

  root 'cse_class#index'
  get 'cse_class/edit_page', to: "cse_class#edit_page"
  get 'cse_class/create', to: "cse_class#create"
  get 'cse_class/delete_all', to: "cse_class#delete_all"
  get 'cse_class/scrape', to: "cse_class#scrape"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
