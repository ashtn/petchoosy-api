Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pets, only: [:index, :show], param: :id
  resources :pet_list#, only: [:create, :show, :destroy], param: :id
  post '/login', to: 'user#login'
end
