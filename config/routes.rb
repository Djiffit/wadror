Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  resources :ratings, only:[:new, :create, :index, :destroy]
  get 'signup', to: 'users#new'
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  get 'places', to: 'places#index'
  post 'places', to: 'places#search'
  resources :places, only:[:index, :show]
  delete 'signout', to: 'sessions#destroy'
  delete 'memberships', to: 'memberships#destroy'
end
