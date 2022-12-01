Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :items do
    resources :bookings, only: %i[new create]
  end
  resources :bookings, only: %i[show index] do
    resources :seller_reviews, only: %i[new create edit update]
    resources :item_reviews, only: %i[new create]
  end
end
