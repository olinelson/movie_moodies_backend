Movie.destroy_all
Genre.destroy_all
Mood.destroy_all
MovieMood.destroy_all
MovieGenre.destroy_all
Video.destroy_all

def apiKey
  "d2001c75a6bc64e98cc457d9b2a86444"
end

combinedCalls = []
#
mostPopularMovies1 = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d2001c75a6bc64e98cc457d9b2a86444&page=1", headers: {'Content-Type': 'application/json', 'Accept': 'application/json'})
hash1 = JSON.parse(mostPopularMovies1)
combinedCalls.push(hash1["results"])


mostPopularMovies2 = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d2001c75a6bc64e98cc457d9b2a86444&page=2", headers: {'Content-Type': 'application/json', 'Accept': 'application/json'})
hash2 = JSON.parse(mostPopularMovies2)
combinedCalls.push(hash2["results"])

mostPopularMovies3 = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d2001c75a6bc64e98cc457d9b2a86444&page=3", headers: {'Content-Type': 'application/json', 'Accept': 'application/json'})
hash3 = JSON.parse(mostPopularMovies3)
combinedCalls.push(hash3["results"])

mostPopularMovies4 = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d2001c75a6bc64e98cc457d9b2a86444&page=4", headers: {'Content-Type': 'application/json', 'Accept': 'application/json'})
hash4 = JSON.parse(mostPopularMovies4)
combinedCalls.push(hash4["results"])

mostPopularMovies5 = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d2001c75a6bc64e98cc457d9b2a86444&page=5", headers: {'Content-Type': 'application/json', 'Accept': 'application/json'})
hash5 = JSON.parse(mostPopularMovies5)
combinedCalls.push(hash5["results"])

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
newMovie = Movie.create(title: movie["title"], length: 120, release: movie["release_date"], image: "#{imageUrl}#{movie['poster_path']}", description: movie['overview'], apiId: movie['id'])

movie["genre_ids"].each do |gId|
  MovieGenre.create(movie_id: newMovie.id, genre_id: findGenreByApiId(gId).first.id)
end

end

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


def findMoodByName(moodName)
  Mood.all.select do |m|
    m.name == moodName
  end
end

def assignMoodByDescriptionKeywords(moodName, keywordsArray)
  Movie.all.each do |movie|
    keywordsArray.each do |keyWord|
      if movie.description.include?(keyWord)
        MovieMood.create(movie_id: movie.id, mood_id: findMoodByName(moodName).first.id )
        # print(movie_id: movie.id, mood_id: findMoodByName(moodName) )
      end
    end
  end
end






happyWords = ["Laughter", "happiness", "love", "happy", "laughed", "laugh", "laughing", "excellent", "laughs", "joy", "successful", "win", "rainbow", "smile", "won", "pleasure", "smiled", "rainbows", "winning", "celebration", "enjoyed", "healthy", "music", "celebrating", "congratulations", "weekend", "celebrate", "comedy", "jokes", "rich", "victory", "Christmas", "free", "friendship", "fun", "holidays", "loved", "loves", "loving", "beach", "hahaha", "kissing", "sunshine", "delicious", "friends", "funny", "outstanding", "paradise", "sweetest", "vacation", "butterflies", "freedom", "flower", "great", "sunlight", "sweetheart", "sweetness", "award", "chocolate", "hahahaha", "heaven", "peace", "splendid", "success", "enjoying", "kissed", "attraction", "celebrated", "hero", "hugs", "positive", "sun", "birthday", "blessed", "fantastic", "winner", "delight", "beauty", "butterfly,entertainment", "funniest", "honesty", "sky", "smiles", "succeed", "wonderful", "glorious", "kisses", "promotion", "family", "gift", "humor", "romantic", "cupcakes", "festival", "hahahahaha", "honour", "relax", "weekends", "angel", "bonus", "brilliant", "diamonds", "holiday", "lucky", "mother", "super", "amazing", "angels", "enjoy", "friend", "friendly", "mother’s", "profit", "finest", "bday", "champion", "grandmother", "haha", "kiss", "kitten", "miracle", "mom", "sweet", "blessings", "bright", "cutest", "entertaining", "excited", "excitement", "joke", "millionaire", "prize", "succeeded", "successfully", "winners", "shines", "awesome", "genius", "achievement", "cake", "cheers", "exciting", "goodness", "hug", "income", "party", "puppy", "smiling", "song", "succeeding", "tasty", "victories", "achieved", "billion", "cakes", "easier", "flowers", "gifts", "gold", "merry", "families", "handsome", "lovers", "affection", "candy", "cute", "diamond", "earnings", "interesting", "peacefully", "praise", "relaxing", "roses", "Saturdays", "faithful", "heavens", "cherish", "comfort", "congrats", "cupcake", "earn", "extraordinary", "glory", "hilarious", "moonlight", "optimistic", "peaceful", "romance", "feast", "attractive", "glad", "grandma", "internet", "pleasant", "profits", "smart"]

sadWords = ["bitter", "blue", "cheerless", "despairing", "dismal", "distraught", "down", "forlorn", "gloomy", "glum", "heartbroken", "heavyhearted", "lonely", "lost", "melancholy", "miserable", "mournful", "negative", "depressed", "sad", "pensive", "pessimistic", "somber", "sorry", "unhappy"]

scaryWords = ["scary", "frightening", "scaring", "terrifying", "petrifying", "chilling", "horrifying", "alarming", "appalling", "daunting", "formidable", "fearsome", "nerve-racking", "unnerving", "eerie", "sinister", "creepy", "spooky", "hairy"]

funnyWords = ["amusing", "humorous", "comic", "comical", "droll", "laughable", "chucklesome", "hilarious", "hysterical", "riotous", "uproarious", "witty", "facetious", "jolly", "jocular", "entertaining", "diverting", "sparkling", "scintillating", "silly", "absurd", "ridiculous", "ludicrous", "risible", "farcical", "preposterous", "slapstick"]

angryWords = ["Abandon", "Account", "Acid", "Action", "Advance", "Aerial", "Afloat", "Aggressor", "Agitator", "Aim", "Aircraft", "Airfield", "Airplane", "Alert", "Alliance", "Allies", "Ambush", "Ammunition", "Anarchy", "Anguish", "Annihilate", "Apartheid", "Appeasement", "Armament", "Armed forces", "Armory", "Arms", "Arsenal", "Artillery", "Ashore", "Assassin", "Assassinate", "Assault", "Atrocity", "Attack", "Attrition", "Authority", "Automatic", "Barrage", "Barricade", "Battalion", "Batter", "Battle", "Battlefield", "Bayonet", "Belligerent", "Betray", "Blast", "Blindside", "Blood(y)", "Bloodletting", "Bomb", "Bombard(ment)", "Booby trap", "Breach", "Brigade", "Brutal", "Brutality", "Bullet", "Bulletproof", "Bunker", "Burn", "Bury", "Cadaver", "Camouflage", "Campaign", "Cannon", "Captive", "Captive", "Capture", "Carbine", "Carcass", "Careen", "Cargo", "Carnage", "Carrier", "Casualties", "Cataclysm", "Caution(ary)", "Cautious", "Chaos", "Charge", "Charred", "Checkpoint", "Chief", "Chopper", "Civilian", "Clandestine", "Clash", "Coalition", "Collapse", "Combat", "Combat", "Command", "Commander", "Commandos", "Compassion", "Compliance", "Concentration", "Conciliatory", "Concussion", "Conflagration", "Conflict", "Confrontation(al)", "Confusion", "Conquer", "Conscript", "Conscription", "Consequences", "Consolidate", "Conspiracy", "Conspire", "Contact", "Control", "Convoy", "Coordinate", "Coordinates", "Corps", "Corpse", "Counterattack", "Countermand", "Counteroffensive", "Courageous", "Crisis", "Cross-hairs", "Culpability", "Damage", "Danger", "Dangerous", "Dash", "Dead", "Deadly", "Death", "Debacle", "Debris", "Decline", "Defect", "Defend", "Defense", "Defensive", "Demolish", "Demoralization", "Deploy", "Desertion", "Despot", "Destroy", "Destruction", "Detect", "Detection", "Detente", "Devastation", "Device", "Dictator", "Die", "Disarmament", "Disarray", "Disaster", "Disastrous", "Discipline", "Disease", "Dismantle", "Dispatch", "Disperse", "Dispute", "Disruption", "Dissonance", "Dominate", "Doomed", "Downfall", "Drama", "Dread", "Drone", "Duck", "Duty", "Elite", "Encounter", "Endurance", "Enemy", "Enforcement", "Engagement", "Enlist", "Epithet", "Escalation", "Escape", "Espionage", "Evacuate", "Evacuee", "Excess", "Execute", "Execution", "Exercise", "Expectations", "Explode", "Exploitation", "Explosion", "Explosive", "Expunge", "Extremism", "Faction", "Fanatic", "Fatal", "Fear", "Fearless", "Ferment", "Ferocious", "Feud", "Fierce", "Fiery", "Fight", "Fighter", "Flank", "Flee", "Flight", "Force(s)", "Forceful", "Fortification", "Foxhole", "Fray", "Frenzy", "Fright", "Front lines", "Fuel", "Fugitive", "Furtive", "Fusillade", "Garrison", "Gas", "Generator", "Genocide", "Germ warfare", "Gore", "Government", "Grave", "Grenade", "Grievous", "Groans", "Guard", "Guerrilla", "Guided bombs", "Guns", "Gunship", "Hammering", "Harsh", "Hatch", "Hate", "Hatred", "Hazards", "Helicopter", "Hero(ic)", "Heroism", "Hide", "Hijack", "Hijacker", "Hit", "Hit-and-run", "Holocaust", "Horses", "Hospitalize", "Hostility", "Howitzer", "Ignite", "Impact", "Improvise", "Incident", "Incite", "Incontrovertible", "Infantry", "Inferred", "Infiltrate", "Inflame", "Informant", "Injuries", "Instructions", "Insurgent", "Insurrection", "Intelligence", "Intense", "Intercept", "Interdiction", "International", "Interrogation", "Intervene", "Intimidate", "Invasion", "Investigate", "Investigations", "Involvement", "Ire", "Jeer", "Jets", "Join", "Keening", "Kidnap", "Kill", "Knives", "Knock-out", "Lamentation", "Land mines", "Laser-activated", "Launch", "Launcher", "Legacy", "Liaison", "Liberate", "Liberation", "Liberators", "Loathsome", "Loyalty", "Macabre", "Machine guns", "Machines", "Maim", "Malevolent", "Malicious", "Marauding", "March", "Massacre", "Mayhem", "Megalomania", "Menacing", "Militancy", "Militant", "Militaristic", "Military", "Militia", "Mines", "Missile", "Mission", "Mistreatment", "Mobile", "Mobilization", "Momentum", "Mortars", "Munitions", "Murder", "Muscle", "Musket", "Mustard gas", "Nationalist", "Negotiation", "Neutralize", "Nightmare", "Nitrate", "Notorious", "Offensive", "Officer", "Officials", "Onerous", "Operation", "Opposition", "Options", "Order", "Outbreak", "Overrun", "Overthrow", "Pacify", "Paramedics", "Partisan", "Patriot", "Patriotism", "Patrol", "Peacekeeping", "Penetration", "Performance", "Persecute", "Petrify", "Photos", "Pilot", "Pistol", "Planes", "Platoon", "Plunder", "Position", "Post-traumatic", "Potent", "Pounds", "Powder", "Power", "Powerful", "Preemptive", "Premeditated", "Prey", "Prison", "Prisoner", "Proliferation", "Provocation", "Prowl", "Pugnacious", "Pulverize", "Quail", "Quarrel", "Queasy", "Quell", "Quest", "Questions", "Quiver", "Radiation", "Radical", "Rage", "Rally", "Ravage", "Ravish", "Readiness", "Rebel", "Rebellion", "Reconnaissance", "Recovery", "Recruitment", "Red Cross", "Reform", "Refugee", "Regime", "Regiment", "Reinforcements", "Relentless", "Reparation", "Reprisal", "Reputation", "Rescue", "Resistance", "Retaliation", "Retreat", "Retribution", "Revenge", "Revolution", "Ricochet", "Rifle", "Rift", "Rival", "Rocket", "Rot", "Rounds", "Rule", "Ruthless(ness)", "Sabotage", "Sacrifice", "Salvage", "Sanction", "Savage", "Scare", "Score", "Scramble", "Secrecy", "Secret", "Security", "Sedition", "Seize", "Seizure", "Sensors", "Setback", "Shelling", "Shells", "Shock", "Shoot", "Shot", "Showdown", "Siege", "Skirmish", "Slaughter", "Smuggle", "Soldier", "Special-ops", "Specialized", "Spokesman", "Spotter", "Spy", "Spy satellite", "Squad", "Stash", "Stealth", "Storage", "Storm", "Straggler", "Strangle", "Strategic", "Strategist", "Strategy", "Strife", "Strike", "Strip", "Stronghold", "Struggle", "Submarine", "Subversive", "Suffering", "Superstition", "Supplies", "Support", "Suppression", "Surprise", "Surrender", "Survival", "Survivor", "Suspect", "Sword", "Tactics", "Tank", "Target", "Tension", "Terrain", "Terror", "Terrorism", "Terrorist", "Terrorize", "Threaten", "Thwart", "Topple", "Torch", "Torpedo", "Tourniquet", "Tragic", "Training", "Trampling", "Transportation", "Trap", "Trauma", "Treachery", "Trench", "Trigger", "Triumph", "Turbulent", "Unbelievable", "Unconventional", "Uniform", "Unify", "Unit", "Unite", "Unleash", "Uprising", "Urgency", "Valiant", "Valor", "Vanguard", "Vanish", "Vehicle", "Vehicular", "Vendetta", "Venomous", "Versatile", "Veteran", "Vicious", "Victory", "Vile", "Vilify", "Violation", "Violence", "Virulence", "Vision", "Visionary", "Vital", "Vitriol", "Vociferous", "Void", "Vow", "Vulnerability", "Wage", "War", "Warheads", "Warplane", "Warrant", "Warrior", "Watchdog", "Watchful", "Weapon", "Well-trained", "Whiz", "Wince", "Wisdom", "Worldwide", "Wounds", "Wreckage"]

 boredWords = ["dull", "humdrum", "lifeless", "monotonous", "mundane", "stale", "stodgy", "stuffy", "stupid", "tame", "tedious", "tiresome", "tiring", "trite", "uninteresting", "bomb", "bummer", "cloying", "commonplace", "dead", "drab", "drag", "drudging", "flat", "nothing", "nowhere", "plebeian", "routine", "stereotyped", "zero", "arid", "bromidic", "characterless", "colorless", "ho", "hum", "insipid", "interminable", "irksome", "moth-eaten", "platitudinous", "prosaic", "repetitious", "spiritless", "threadbare", "unexciting", "unvaried", "vapid", "wearisome", "well-worn"]
 romanticWords = ["affair", "amour", "attachment", "courtship", "enchantment", "fascination", "fling", "flirtation", "intrigue", "liaison", "love", "passion", "relationship", "affair", "heart", "love", "story"]
hungryWords = ["breakfast", "lunch", "dinner", "snacks", "eager", "greedy", "keen", "ravenous", "starved", "athirst", "avid", "carnivorous", "could", "eat", "horse", "covetous", "craving", "edacious", "empty", "esurient", "famished", "famishing", "light", "got", "munchies", "hankering", "hoggish", "hollow", "hungered", "insatiate", "omnivorous", "empty", "stomach", "piggish", "rapacious", "unfilled", "unsatisfied", "voracious", "yearning"]
snarkyWords = ["cynical", "snide", "irascible", "irreverent", "sarcastic", "scornful", "spiteful", "testy", "abrasive", "caustic", "cutting", "impertinent"]



assignMoodByDescriptionKeywords('happy', happyWords)
assignMoodByDescriptionKeywords('sad', sadWords)
assignMoodByDescriptionKeywords('scary', scaryWords)
assignMoodByDescriptionKeywords('funny', funnyWords)
assignMoodByDescriptionKeywords('angry', angryWords)
assignMoodByDescriptionKeywords('bored', boredWords)
assignMoodByDescriptionKeywords('romantic',romanticWords)
assignMoodByDescriptionKeywords('hungry', hungryWords)
assignMoodByDescriptionKeywords('snarky', snarkyWords)

def assignMoodByGenre(moodName, genreNames)
  Movie.all.each do |movie|
    movie.genres.each do |genre|
      genreNames.each do |genreName|
        if genre.name.include?(genreName)
            MovieMood.create(movie_id: movie.id, mood_id: findMoodByName(moodName).first.id )
        end
      end
    end
  end
end

happyGenres = ["Comedy", "Romance", "Animation", "Family"]
scaryGenres = ["Crime", "Horror", "Thriller"]
sadGenres = ["Drama", "War", "Crime","Documentary"]
funnyGenres = ["Fantasy", "Comedy", "Animation",]
angryGenres = ["Action", "Crime", "Fantasy", "Horror", "Thriller", "War"]
boredGenres = ["Action", "Adventure", "Fantasy", "Science Fiction"]
romanticGenres = ["Family", "Romance"]
hungryGenres = ["Family", "Documentary"]
snarkyGenres = ["Documentary", "Drama", "Mystery"]


assignMoodByGenre('funny', happyGenres)
assignMoodByGenre('scary', happyGenres)
assignMoodByGenre('sad', sadGenres)
assignMoodByGenre('funny', funnyGenres)
assignMoodByGenre('angry', angryGenres)
assignMoodByGenre('bored', boredGenres)
assignMoodByGenre('romantic', romanticGenres)
assignMoodByGenre('hungry', hungryGenres)
assignMoodByGenre('snarky', snarkyGenres)




  Movie.all[81..100].each do |movie|
    response = ::RestClient::Request.execute(method: :get, url: "https://api.themoviedb.org/3/movie/#{movie.apiId}/videos?api_key=d2001c75a6bc64e98cc457d9b2a86444&language=en-US", headers: {'Content-Type': 'application/json', 'Accept': 'application/json'})
    hash1 = JSON.parse(response)['results']
    hash1.each do |item|
      Video.create(name: item["name"], domain: item["site"], url_key: item["key"], movie_id: movie.id)
    end
  end



  # should create a new model with serializer that has all the movie keys
