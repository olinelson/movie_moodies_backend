# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#



50.times do
  Movie.create(title: Faker::Book.title, length: rand(20..240), release: Faker::Date.birthday(1, 50), image:"https://3.bp.blogspot.com/-NR5TQG15EQU/UrCYGi7FYDI/AAAAAAAAARQ/bUh7usV1HFY/s1600/casablanca-poster-artwork-humphrey-bogart-ingrid-bergman-paul-henreid.jpg", description: "Quo sunt voluptatem mollitia libero vel aut est. Ut ea quis aliquam eum voluptatem odio sed eaque. Quidem laboriosam iste laboriosam voluptatibus. Aperiam est commodi tempore totam. Nihil quaerat dolores eius aliquid libero delectus beatae eos.")
end

 moodNames = ["Happy", "Sad", "Judgemental", "Disappointed", "Mad", "Anxious", "Depressed", "Bored", "Optimistic", "Inspired", "Excited", "Amused", "Energetic"]



 moodNames.each do |moodName|
   Mood.create( name: moodName )
 end
