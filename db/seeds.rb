#PARKS+REC - RON SWANSON API
response_string = RestClient.get('http://ron-swanson-quotes.herokuapp.com/v2/quotes/50')
response_hash = JSON.parse(response_string)
  response_hash.each do |each_quote|
    Game.create(show: "Parks and Rec", quote: each_quote)
  end

#THE OFFICE
50.times do
  Game.find_or_create_by(show: "The Office", quote: Faker::MichaelScott.quote)
end

#SEINFELD
50.times do
  Game.find_or_create_by(show: "Seinfeld", quote: Faker::Seinfeld.quote)
end

#FRIENDS
50.times do
  Game.find_or_create_by(show: "Friends", quote: Faker::Friends.quote)
end

# #NEW GIRL
# 50.times do
#   Game.find_or_create_by(show: "New Girl", quote: Faker::NewGirl.quote)
# end

#IT CROWD
50.times do
  Game.find_or_create_by(show: "The IT Crowd", quote: Faker::TheITCrowd.quote)
end

# #Silicon Valley
# 50.times do
#   Game.find_or_create_by(show: "Silicon Valley", quote: Faker::SiliconValley.quote)
# end

#How I Met Your Mother
50.times do
  Game.find_or_create_by(show: "How I Met Your Mother", quote: Faker::HowIMetYourMother.quote)
end
