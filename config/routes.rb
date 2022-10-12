Rails.application.routes.draw do
  root 'home#index'
  get 'home/about'

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
end
