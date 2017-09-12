Rails.application.routes.draw do

  match 'confirm', to: 'confirms#create', as: 'confirm', via: [:post]
  match 'order', to: 'orders#index', as: 'order', via: [:get]

  get 'home/index'
  root 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :orders, only: [:create, :index]

  resources :confirms, only: [:create]

 end
