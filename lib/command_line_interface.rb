def welcome
  puts "Welcome! Please enter your username"
  username = gets.chomp   #TAKES IN USERNAME
  User.create(username: username)
end

def play_game
  puts "try to match quote to the show - CHANGE THIS LATER"
  puts "\n"
  puts Game.all.sample.quote
  puts "\n"
  puts Game.all
  binding.pry

  puts " "
end
