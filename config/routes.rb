Rails.application.routes.draw do
  resources :add_status_to_memberships
  resources :styles
  resources :beers
  resources :memberships do
    post 'approve_member', on: :member
  end
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_ban', on: :member
  end
  resources :beer_clubs
  resources :breweries
  get 'auth/:provider/callback', to: 'sessions#create_oauth'
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  resources :ratings, only:[:new, :create, :index, :destroy]
  get 'signup', to: 'users#new'
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  get 'places', to: 'places#index'
  post 'places', to: 'places#search'
  resources :places, only:[:index, :show]
  get 'beerlist', to:'beers#list'
  get 'brewerylist', to:'breweries#list'
  get 'ngbeerlist', to:'beers#nglist'
  delete 'signout', to: 'sessions#destroy'
  delete 'memberships', to: 'memberships#destroy'
end
