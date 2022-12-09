Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :items do
    resources :bookings, only: %i[new create]
  end
  get "my_items", to: "items#my_items", as: :my_items
  resources :bookings, only: %i[show index edit update] do
    resources :seller_reviews, only: %i[new create edit update]
    resources :item_reviews, only: %i[new create]
  end
end
