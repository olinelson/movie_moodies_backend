

mostPopularMovies = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d2001c75a6bc64e98cc457d9b2a86444', headers: {'Content-Type': 'application/json', 'Accept': 'application/json"})
hash = JSON.parse(mostPopularMovies)
movies = hash["results"]
imageUrl= "https://image.tmdb.org/t/p/w500"

movies.each do |movie|
  Movie.create(title: movie["title"], length: 120, release: movie["release_date"], image: "#{imageUrl}#{movie['poster_path']}", description: movie['overview'])
end


#
# 50.times do
#   Movie.create(title: Faker::Book.title, length: rand(20..240), release: Faker::Date.birthday(1, 50), image:"https://3.bp.blogspot.com/-NR5TQG15EQU/UrCYGi7FYDI/AAAAAAAAARQ/bUh7usV1HFY/s1600/casablanca-poster-artwork-humphrey-bogart-ingrid-bergman-paul-henreid.jpg", description: "Quo sunt voluptatem mollitia libero vel aut est. Ut ea quis aliquam eum voluptatem odio sed eaque. Quidem laboriosam iste laboriosam voluptatibus. Aperiam est commodi tempore totam. Nihil quaerat dolores eius aliquid libero delectus beatae eos.")
# end

 moodNames = ["Happy", "Sad", "Judgemental", "Disappointed", "Mad", "Anxious", "Depressed", "Bored", "Optimistic", "Inspired", "Excited", "Amused", "Energetic"]



 moodNames.each do |moodName|
   Mood.create( name: moodName )
 end

 100.times do
   MovieMood.create(movie_id: Movie.all.sample.id, mood_id: Mood.all.sample.id)
 end
