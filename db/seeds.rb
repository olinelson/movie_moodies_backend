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

# Movie.all.each do |movie|
#   movie.genres.each do |g|
#     if g.name == "Comedy" || g.name == "Animation" || g.name == "Fantasy"
#       MovieMood.create(movie_id: movie.id, mood_id: 1)
#     end
#
#     if g.name == "Crime" || g.name == "Horror" || g.name == "Thriller" || g.name == "War" || g.name == "Documentary"
#       MovieMood.create(movie_id: movie.id, mood_id: 2)
#     end
#
#     if g.name == "Horror" || g.name == "War" || g.name == "Thriller"
#       MovieMood.create(movie_id: movie.id, mood_id: 3)
#     end
#
#     if g.name == "Comedy" || g.name == "Romance" || g.name == "Family"
#       MovieMood.create(movie_id: movie.id, mood_id: 4)
#     end
#
#     if g.name == "War" || g.name == "Documentary" || g.name == "Action" || g.name == "Western"
#       MovieMood.create(movie_id: movie.id, mood_id: 5)
#     end
#
#     if g.name == "Adventure" || g.name == "Documentary" || g.name == "Mystery" || g.name == "Science Fiction"
#       MovieMood.create(movie_id: movie.id, mood_id: 6)
#     end
#
#     if g.name == "Romance" || g.name == "Family" || g.name == "Fantasy" || g.name == "Drama"
#       MovieMood.create(movie_id: movie.id, mood_id: 7)
#     end
#
#     if g.name == "Adventure" || g.name == "Documentary" || g.name == "Family"
#       MovieMood.create(movie_id: movie.id, mood_id: 8)
#     end
#
#     if g.name == "Animation" || g.name == "Comedy" || g.name == "Drama" || g.name == "TV Movie"
#       MovieMood.create(movie_id: movie.id, mood_id: 9)
#     end
#
# end
#
# end

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






# happyWords = ['love','happy','laugh','adventure','destiny','smile','awesome']
# sadWords = ['war','fight','death','fight']
# scaryWords = ['haunted', 'scary', 'dying','death','survive']
# funnyWords = ['laugh', 'smile', 'happy', 'friend', 'pal']
angryWords = ["Abandon", "Account", "Acid", "Action", "Advance", "Aerial", "Afloat", "Aggressor", "Agitator", "Aim", "Aircraft", "Airfield", "Airplane", "Alert", "Alliance", "Allies", "Ambush", "Ammunition", "Anarchy", "Anguish", "Annihilate", "Apartheid", "Appeasement", "Armament", "Armed forces", "Armory", "Arms", "Arsenal", "Artillery", "Ashore", "Assassin", "Assassinate", "Assault", "Atrocity", "Attack", "Attrition", "Authority", "Automatic", "Barrage", "Barricade", "Battalion", "Batter", "Battle", "Battlefield", "Bayonet", "Belligerent", "Betray", "Blast", "Blindside", "Blood(y)", "Bloodletting", "Bomb", "Bombard(ment)", "Booby trap", "Breach", "Brigade", "Brutal", "Brutality", "Bullet", "Bulletproof", "Bunker", "Burn", "Bury", "Cadaver", "Camouflage", "Campaign", "Cannon", "Captive", "Captive", "Capture", "Carbine", "Carcass", "Careen", "Cargo", "Carnage", "Carrier", "Casualties", "Cataclysm", "Caution(ary)", "Cautious", "Chaos", "Charge", "Charred", "Checkpoint", "Chief", "Chopper", "Civilian", "Clandestine", "Clash", "Coalition", "Collapse", "Combat", "Combat", "Command", "Commander", "Commandos", "Compassion", "Compliance", "Concentration", "Conciliatory", "Concussion", "Conflagration", "Conflict", "Confrontation(al)", "Confusion", "Conquer", "Conscript", "Conscription", "Consequences", "Consolidate", "Conspiracy", "Conspire", "Contact", "Control", "Convoy", "Coordinate", "Coordinates", "Corps", "Corpse", "Counterattack", "Countermand", "Counteroffensive", "Courageous", "Crisis", "Cross-hairs", "Culpability", "Damage", "Danger", "Dangerous", "Dash", "Dead", "Deadly", "Death", "Debacle", "Debris", "Decline", "Defect", "Defend", "Defense", "Defensive", "Demolish", "Demoralization", "Deploy", "Desertion", "Despot", "Destroy", "Destruction", "Detect", "Detection", "Detente", "Devastation", "Device", "Dictator", "Die", "Disarmament", "Disarray", "Disaster", "Disastrous", "Discipline", "Disease", "Dismantle", "Dispatch", "Disperse", "Dispute", "Disruption", "Dissonance", "Dominate", "Doomed", "Downfall", "Drama", "Dread", "Drone", "Duck", "Duty", "Elite", "Encounter", "Endurance", "Enemy", "Enforcement", "Engagement", "Enlist", "Epithet", "Escalation", "Escape", "Espionage", "Evacuate", "Evacuee", "Excess", "Execute", "Execution", "Exercise", "Expectations", "Explode", "Exploitation", "Explosion", "Explosive", "Expunge", "Extremism", "Faction", "Fanatic", "Fatal", "Fear", "Fearless", "Ferment", "Ferocious", "Feud", "Fierce", "Fiery", "Fight", "Fighter", "Flank", "Flee", "Flight", "Force(s)", "Forceful", "Fortification", "Foxhole", "Fray", "Frenzy", "Fright", "Front lines", "Fuel", "Fugitive", "Furtive", "Fusillade", "Garrison", "Gas", "Generator", "Genocide", "Germ warfare", "Gore", "Government", "Grave", "Grenade", "Grievous", "Groans", "Guard", "Guerrilla", "Guided bombs", "Guns", "Gunship", "Hammering", "Harsh", "Hatch", "Hate", "Hatred", "Hazards", "Helicopter", "Hero(ic)", "Heroism", "Hide", "Hijack", "Hijacker", "Hit", "Hit-and-run", "Holocaust", "Horses", "Hospitalize", "Hostility", "Howitzer", "Ignite", "Impact", "Improvise", "Incident", "Incite", "Incontrovertible", "Infantry", "Inferred", "Infiltrate", "Inflame", "Informant", "Injuries", "Instructions", "Insurgent", "Insurrection", "Intelligence", "Intense", "Intercept", "Interdiction", "International", "Interrogation", "Intervene", "Intimidate", "Invasion", "Investigate", "Investigations", "Involvement", "Ire", "Jeer", "Jets", "Join", "Keening", "Kidnap", "Kill", "Knives", "Knock-out", "Lamentation", "Land mines", "Laser-activated", "Launch", "Launcher", "Legacy", "Liaison", "Liberate", "Liberation", "Liberators", "Loathsome", "Loyalty", "Macabre", "Machine guns", "Machines", "Maim", "Malevolent", "Malicious", "Marauding", "March", "Massacre", "Mayhem", "Megalomania", "Menacing", "Militancy", "Militant", "Militaristic", "Military", "Militia", "Mines", "Missile", "Mission", "Mistreatment", "Mobile", "Mobilization", "Momentum", "Mortars", "Munitions", "Murder", "Muscle", "Musket", "Mustard gas", "Nationalist", "Negotiation", "Neutralize", "Nightmare", "Nitrate", "Notorious", "Offensive", "Officer", "Officials", "Onerous", "Operation", "Opposition", "Options", "Order", "Outbreak", "Overrun", "Overthrow", "Pacify", "Paramedics", "Partisan", "Patriot", "Patriotism", "Patrol", "Peacekeeping", "Penetration", "Performance", "Persecute", "Petrify", "Photos", "Pilot", "Pistol", "Planes", "Platoon", "Plunder", "Position", "Post-traumatic", "Potent", "Pounds", "Powder", "Power", "Powerful", "Preemptive", "Premeditated", "Prey", "Prison", "Prisoner", "Proliferation", "Provocation", "Prowl", "Pugnacious", "Pulverize", "Quail", "Quarrel", "Queasy", "Quell", "Quest", "Questions", "Quiver", "Radiation", "Radical", "Rage", "Rally", "Ravage", "Ravish", "Readiness", "Rebel", "Rebellion", "Reconnaissance", "Recovery", "Recruitment", "Red Cross", "Reform", "Refugee", "Regime", "Regiment", "Reinforcements", "Relentless", "Reparation", "Reprisal", "Reputation", "Rescue", "Resistance", "Retaliation", "Retreat", "Retribution", "Revenge", "Revolution", "Ricochet", "Rifle", "Rift", "Rival", "Rocket", "Rot", "Rounds", "Rule", "Ruthless(ness)", "Sabotage", "Sacrifice", "Salvage", "Sanction", "Savage", "Scare", "Score", "Scramble", "Secrecy", "Secret", "Security", "Sedition", "Seize", "Seizure", "Sensors", "Setback", "Shelling", "Shells", "Shock", "Shoot", "Shot", "Showdown", "Siege", "Skirmish", "Slaughter", "Smuggle", "Soldier", "Special-ops", "Specialized", "Spokesman", "Spotter", "Spy", "Spy satellite", "Squad", "Stash", "Stealth", "Storage", "Storm", "Straggler", "Strangle", "Strategic", "Strategist", "Strategy", "Strife", "Strike", "Strip", "Stronghold", "Struggle", "Submarine", "Subversive", "Suffering", "Superstition", "Supplies", "Support", "Suppression", "Surprise", "Surrender", "Survival", "Survivor", "Suspect", "Sword", "Tactics", "Tank", "Target", "Tension", "Terrain", "Terror", "Terrorism", "Terrorist", "Terrorize", "Threaten", "Thwart", "Topple", "Torch", "Torpedo", "Tourniquet", "Tragic", "Training", "Trampling", "Transportation", "Trap", "Trauma", "Treachery", "Trench", "Trigger", "Triumph", "Turbulent", "Unbelievable", "Unconventional", "Uniform", "Unify", "Unit", "Unite", "Unleash", "Uprising", "Urgency", "Valiant", "Valor", "Vanguard", "Vanish", "Vehicle", "Vehicular", "Vendetta", "Venomous", "Versatile", "Veteran", "Vicious", "Victory", "Vile", "Vilify", "Violation", "Violence", "Virulence", "Vision", "Visionary", "Vital", "Vitriol", "Vociferous", "Void", "Vow", "Vulnerability", "Wage", "War", "Warheads", "Warplane", "Warrant", "Warrior", "Watchdog", "Watchful", "Weapon", "Well-trained", "Whiz", "Wince", "Wisdom", "Worldwide", "Wounds", "Wreckage"]

# boredWords
# romanticWords
# hungryWords
# snarkyWords



assignMoodByDescriptionKeywords('angry', angryWords)
