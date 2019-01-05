Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: 'json' } do
  	scope module: :v1 do
  		post 'login' => 'sessions#create', as: :login
  		get 'logout' => 'sessions#destroy', as: :logout
  		post 'signup' => 'registrations#create', as: :signup
  		resources :lists
  	end
  end
end
