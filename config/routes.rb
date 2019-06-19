Rails.application.routes.draw do
  get '/', to: "books#index"

  #resources :books, only: [:index, :show, :destroy, :new, :create]
  #resources :authors, only: [:index, :show]
  #resources :users, only: [:index, :show]
  #resources :reviews, only: [:destroy, :new, :create]

  get '/books', to: "books#index", as: "books"
  post '/books', to: "books#index"
  get '/books/new', to: "books#create", as: "new_book"
  get '/books/:id', to: "books#show", as: "book"
  delete '/books/:id', to: "books#destroy"
  get '/authors', to: "authors#index", as: "authors"
  get '/authors/:id', to: "authors#show", as: "author"
  delete '/authors/:id', to: "authors#destroy"
  get '/users', to: "users#index", as: "users"
  get '/users/:id', to: "users#show", as: "user"
  post '/reviews', to: "reviews#create", as: "reviews"
  get '/reviews/new', to: "reviews#new", as: "new_review"
  delete '/reviews/:id', to: "reviews#destroy", as: "review"
end
