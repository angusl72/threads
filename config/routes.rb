Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :items do
    resources :booking, only: %i[new create]
  end
  resources :booking, only: %i[show index] do
    resources :seller_reviews, only: %i[new create]
    resources :item_reviews, only: %i[new create]
  end
end
