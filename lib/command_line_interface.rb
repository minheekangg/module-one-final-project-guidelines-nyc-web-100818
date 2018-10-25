require 'JSON'

class CLI
 attr_accessor :user, :game, :game_score


 def initialize
   @prompt = TTY::Prompt.new
 end

 def welcome
   puts "Welcome! Please enter your name and hit ENTER."
   username = gets.chomp   #TAKES IN USERNAME
   puts "Hi #{username}, let's play sitcom trivia!!!"
   puts "\n"
   new_user = User.find_or_create_by(username: username)
   @user = new_user
 end

 def start_game
   @game_score = 0
   @shows = []
   get_game =[]
   get_game << Game.all
   @curr_game = get_game.flatten

   puts "Try to guess which show the following quote belongs to."
   puts "\n"
   game_instance = @curr_game.sample
   quote = game_instance.quote
   show_names = Game.all.map { |game| game.show }.uniq
   answer = @prompt.select(quote, show_names)

   @curr_game.delete(game_instance)

   check_answer(quote, answer, game_instance)
 end

 def continue_curr_game
    game_instance = @curr_game.sample   #picks 1 game instance
    quote = game_instance.quote        #takes quote from picked instance

    show_names = Game.all.map { |game| game.show }.uniq     #collects show names
    answer = @prompt.select(quote, show_names)              #SHOWS Q+A

    @curr_game.delete(game_instance)

    check_answer(quote, answer, game_instance)
 end

 def check_answer(quote, answer, game_instance)
   show = Game.all.find_by(quote: quote).show
   if (show == answer)
     puts "CORRECT!"
     @game_score += 1
     @shows << show
     puts "Your score is #{self.game_score}."
     puts "\n"
     continue_curr_game

   else
     puts "UHOH! The correct answer is: #{show}"
     puts "\n"
     @shows << show
     @shows.pop
     @game = game_instance.id
     save_score
     display_score(self.game_score, @shows)
     puts "\n"
     binding.pry
     play_again
   end
 end

 def display_score(score, shows)
   puts "\tYour score for this game is #{score}"
   show_count = Hash.new(0)
   shows.each do |show|
     show_count[show] +=1
   end
   sorted_shows = show_count.sort_by {|k,v| v}.reverse
   sorted_shows.each do |show, score|
     puts "\t#{show} : #{score}"
   end
 end


 def save_score
   Score.find_or_create_by(score: @game_score, user_id: @user.id, game_id: @game, username: @user.username)
 end

 def play_again
   puts "Would you like to play again? Please enter 'Yes' or 'No'."
   answer = gets.chomp.downcase
   if answer == "yes"
     start_game
   elsif answer == "no"
     display_high_score
   else
     play_again
   end
 end

 def display_high_score
   puts "HIGH SCORES"
   sorted_score =  Score.all.sort_by {|obj| obj.score}.reverse
   top10 = sorted_score[0..9]
   top10.each do |each|
     puts "#{each.username} : #{each.score}"
   end
 end

end # end of cli method
