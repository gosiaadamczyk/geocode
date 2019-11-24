Rails.application.routes.draw do
  resources :areas, only: :index
  resources :locations, only: %i[show create]
end
