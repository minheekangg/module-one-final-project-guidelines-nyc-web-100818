# 10.times do
#   User.create(username: Faker::Name.name)
# end
30.times do
  Game.create(show: "The Office", quote: Faker::MichaelScott.quote)
end

30.times do
  Game.create(show: "Seinfeld", quote: Faker::Seinfeld.quote)
end

Score.create(user_id: User.all.sample.id, game_id: Game.all.sample.id)
binding.pry
