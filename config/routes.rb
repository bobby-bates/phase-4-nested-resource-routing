Rails.application.routes.draw do
  resources :dog_houses, only: [:show] do
    # Nested routes for reviews
    resources :reviews, only: [:show, :index]
  end
  # Keep these non-nested routes because we still want to let people see all
  # reviews or a single review, create reviews, etc.,
  # outside of the context of a dog house
  resources :reviews, only: [:show, :index, :create]

  # How it's done w/o nesting routes. Works, but not pretty!
  # get '/dog_houses/:dog_house_id/reviews', to: 'dog_houses#reviews_index'
  # get '/dog_houses/:dog_house_id/reviews/:review_id', to: 'dog_houses#review'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
