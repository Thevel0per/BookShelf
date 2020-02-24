Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get 'basket', to: 'users#basket'
    end
  end
  resources :ebooks
  resources :categories
  resources :orders

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'add_to_basket/:id', to: 'ebooks#add_to_basket'
  delete 'remove_from_basket/:id', to: 'ebooks#remove_from_basket'
  root to: 'ebooks#index'
end
