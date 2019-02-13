combinedCalls = []

mostPopularMovies1 = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d2001c75a6bc64e98cc457d9b2a86444&page=1", headers: {'Content-Type': 'application/json', 'Accept': 'application/json'})
hash1 = JSON.parse(mostPopularMovies1)
combinedCalls.push(hash1["results"])


mostPopularMovies2 = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d2001c75a6bc64e98cc457d9b2a86444&page=2", headers: {'Content-Type': 'application/json', 'Accept': 'application/json'})
hash2 = JSON.parse(mostPopularMovies2)
combinedCalls.push(hash2["results"])

mostPopularMovies3 = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d2001c75a6bc64e98cc457d9b2a86444&page=2", headers: {'Content-Type': 'application/json', 'Accept': 'application/json'})
hash3 = JSON.parse(mostPopularMovies3)
combinedCalls.push(hash3["results"])

# genre request ###############################

genres = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/genre/movie/list?api_key=d2001c75a6bc64e98cc457d9b2a86444&language=en-US", headers: {'Content-Type': 'application/json', 'Accept': 'application/json'})
parsedGenres = JSON.parse(genres)

parsedGenres['genres'].each do |g|
  Genre.create( apiId: g["id"], name: g["name"])
end

# ###############################################

movies = combinedCalls.flatten

imageUrl= "https://image.tmdb.org/t/p/w500"

def findGenreByApiId(query)
  Genre.all.select do |g|
    g.apiId == query
  end
end

movies.each do |movie|
newMovie = Movie.create(title: movie["title"], length: 120, release: movie["release_date"], image: "#{imageUrl}#{movie['poster_path']}", description: movie['overview'])

movie["genre_ids"].each do |gId|
  MovieGenre.create(movie_id: newMovie.id, genre_id: findGenreByApiId(gId).first.id)
end

end
#
 moods = [
   {
     name: "happy",
     icon: "fas fa-smile"
   },
   {
     name: "sad",
     icon: "fas fa-frown"
   },
   {
     name: "scary",
     icon: "fas fa-surprise"
   },
   {
     name: "funny",
     icon: "fas fa-grin-squint-tears"
   },
   {
     name: "angry",
     icon: "fas fa-angry"
   },
   {
     name: "bored",
     icon: "fas fa-meh-rolling-eyes"
   },
   {
     name: "romantic",
     icon: "fas fa-grin-hearts"
   },
   {
     name: "hungry",
     icon: "fas fa-grin-tongue-wink"
   },
   {
     name: "snarky",
     icon: "fas fa-grin-tongue-squint"
   },
 ]

 moods.each do |mood|
   Mood.create( name: mood[:name], image: mood[:icon] )
 end

Movie.all.each do |movie|
  movie.genres.each do |g|
    if g.name == "Comedy" || g.name == "Animation" || g.name == "Fantasy"
      MovieMood.create(movie_id: movie.id, mood_id: 1)
    end

    if g.name == "Crime" || g.name == "Horror" || g.name == "Thriller" || g.name == "War" || g.name == "Documentary"
      MovieMood.create(movie_id: movie.id, mood_id: 2)
    end

    if g.name == "Horror" || g.name == "War" || g.name == "Thriller"
      MovieMood.create(movie_id: movie.id, mood_id: 3)
    end

    if g.name == "Comedy" || g.name == "Romance" || g.name == "Family"
      MovieMood.create(movie_id: movie.id, mood_id: 4)
    end

    if g.name == "War" || g.name == "Documentary" || g.name == "Action" || g.name == "Western"
      MovieMood.create(movie_id: movie.id, mood_id: 5)
    end

    if g.name == "Adventure" || g.name == "Documentary" || g.name == "Mystery" || g.name == "Science Fiction"
      MovieMood.create(movie_id: movie.id, mood_id: 6)
    end

    if g.name == "Romance" || g.name == "Family" || g.name == "Fantasy" || g.name == "Drama"
      MovieMood.create(movie_id: movie.id, mood_id: 7)
    end

    if g.name == "Adventure" || g.name == "Documentary" || g.name == "Family"
      MovieMood.create(movie_id: movie.id, mood_id: 8)
    end

    if g.name == "Animation" || g.name == "Comedy" || g.name == "Drama" || g.name == "TV Movie"
      MovieMood.create(movie_id: movie.id, mood_id: 9)
    end

end
  # MovieMood.create(movie_id: movie.id, mood_id: Mood.all.sample.id)
end
