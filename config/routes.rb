Rails.application.routes.draw do
  devise_for :users
  root 'categories#index'

  resources :categories do
    resources :tasks, only: %i[edit create update destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
