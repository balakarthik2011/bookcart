Rails.application.routes.draw do

  mount Thredded::Engine => '/forum'


  devise_scope :user do
    root 'user/registrations#new'
    get '/', to: 'user/registrations#new'
  end
  devise_for :users
  resource :books, except: :show
  get "/users/:id", to: "user#show"
  get "/books", to: "books#index"
  get "/books/:id", to: "books#show"
  get "/my/books/", to: "books#my_books"
  get "/favourites", to: "books#fav_books"
  get "/favourites/add/:id", to: "books#make_favourite", as: "make_favourite"
  # delete "books/:id", to: "books#destroy", as: "delete_book"
  # get "book/:id", to: "books#edit", as: "edit_book"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
