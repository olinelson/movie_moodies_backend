Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'videos/Controller'
    end
  end
  namespace :api do
    namespace :v1 do
      resources :movies
      resources :moods
      resources :movie_moods
      resources :genres
      resources :movie_genres

    end
  end
end
