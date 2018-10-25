#PARKS+REC - RON SWANSON API
response_string = RestClient.get('http://ron-swanson-quotes.herokuapp.com/v2/quotes/30')
response_hash = JSON.parse(response_string)
  response_hash.each do |each_quote|
    Game.create(show: "Parks and Rec", quote: each_quote)
  end

#THE OFFICE
30.times do
  Game.find_or_create_by(show: "The Office", quote: Faker::MichaelScott.quote)
end

#SEINFELD
30.times do
  Game.find_or_create_by(show: "Seinfeld", quote: Faker::Seinfeld.quote)
end

#FRIENDS
30.times do
  Game.find_or_create_by(show: "Friends", quote: Faker::Friends.quote)
end

#FRIENDS
30.times do
  Game.find_or_create_by(show: "New Girl", quote: Faker::NewGirl.quote)
end
