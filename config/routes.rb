Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :movies
      resources :moods
      resources :movie_moods

    end
  end
end
