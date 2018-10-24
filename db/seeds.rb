#THE OFFICE
30.times do
  Game.create(show: "The Office", quote: Faker::MichaelScott.quote)
end


#SEINFELD
30.times do
  Game.create(show: "Seinfeld", quote: Faker::Seinfeld.quote)
end

#PARKS+REC - RON SWANSON API
response_string = RestClient.get('http://ron-swanson-quotes.herokuapp.com/v2/quotes/30')
response_hash = JSON.parse(response_string)
  response_hash.each do |each_quote|
    Game.create(show: "Parks and Rec", quote: each_quote)
  end
# Score.create(user_id: User.all.sample.id, game_id: Game.all.sample.id)

#BOJACK
30.times do
  Game.create(show: "Bojack Horseman", quote: Faker::BojackHorseman.quote)
end

#FRIENDS
30.times do
  Game.create(show: "Friends", quote: Faker::Friends.quote)
end

#NEW GIRL

30.times do
  Game.create(show: "New Girl", quote: Faker::NewGirl.quote)
end


puts " "
