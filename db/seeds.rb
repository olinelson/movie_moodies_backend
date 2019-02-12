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

movies = combinedCalls.flatten


imageUrl= "https://image.tmdb.org/t/p/w500"

movies.each do |movie|
  Movie.create(title: movie["title"], length: 120, release: movie["release_date"], image: "#{imageUrl}#{movie['poster_path']}", description: movie['overview'])
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
     name: "bemused",
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
  MovieMood.create(movie_id: movie.id, mood_id: Mood.all.sample.id)
end
