Rails.application.routes.draw do
  root 'home#index'
  get 'home/about'
  get 'home/profile'

  get "password", to: "passwords#edit"
  patch "password", to: "passwords#update"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  
  delete "sign_out", to: "sessions#destroy"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  get "auth/twitter/callback", to: 'omniauth_callbacks#twitter'

  resources :twitter_accounts
  resources :tweets

end
