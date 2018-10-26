require 'JSON'

class CLI
 attr_accessor :user, :game, :game_score


 def initialize
   @prompt = TTY::Prompt.new
   @artii = Artii::Base.new  #:font => 'slant'
   @cursor = TTY::Cursor
 end

 def welcome
  puts @artii.asciify('SITCOM TRIVIA!').colorize(:color => :white, :background => :blue)
  puts "              |  /                                                                         ".colorize(:color => :white, :background => :blue)
  puts "              |/                                                                           ".colorize(:color => :white, :background => :blue)
  puts "         .===============.                                                                 ".colorize(:color => :white, :background => :blue)
  puts "         | .-----------. |                                                                 ".colorize(:color => :white, :background => :blue)
  puts "         | |  SITCOM   | |                                                                 ".colorize(:color => :white, :background => :blue)
  puts "         | |  TRIVIA   | |                                                                 ".colorize(:color => :white, :background => :blue)
  puts "         | |  !!!!!!!  | |   __                                                            ".colorize(:color => :white, :background => :blue)
  puts "         | '-----------'o|  |o.|                                                           ".colorize(:color => :white, :background => :blue)
  puts "         |===============|  |::|                                                           ".colorize(:color => :white, :background => :blue)
  puts "         |###############|  |::|                                                           ".colorize(:color => :white, :background => :blue)
  puts "         '==============='  '--'                                                           ".colorize(:color => :white, :background => :blue)

  sleep(1)
  puts "\n"
   puts "Welcome! Please enter your name and hit ENTER."
   username = gets.chomp   #TAKES IN USERNAME
   puts "Hi #{username}, let's play sitcom trivia!!!".colorize(:color => :cyan)
   sleep(1)
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
   puts "\n"
   puts "Try to guess which show the following quote belongs to.".colorize(:color => :magenta)
   puts "3"
   sleep(1)
   puts "2"
   sleep(1)
   puts "1"
   sleep(1)
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
    puts "NEXT QUOTE:".colorize(:color => :magenta)
    answer = @prompt.select(quote, show_names)              #SHOWS Q+A

    @curr_game.delete(game_instance)

    check_answer(quote, answer, game_instance)
 end

 def check_answer(quote, answer, game_instance)
   show = Game.all.find_by(quote: quote).show
   if (show == answer)
     puts "CORRECT!".colorize(:color => :green)
     @game_score += 1
     @shows << show
     puts "Your score is #{self.game_score}."
     puts "\n"
     continue_curr_game

   else
     puts "UHOH! The correct answer is: #{show}".colorize(:color => :white, :background => :red)
     puts "\n"
     @shows << show
     @shows.pop
     @game = game_instance.id
     save_score
     display_score(self.game_score, @shows)
     puts "\n"
     play_again
   end
 end

 def display_score(score, shows)
   puts "\tYour score for this game is #{score}"
   puts "\t------------------------------"
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
     display_hardest_question
   else
     play_again
   end
 end

 def display_high_score
   sleep(1)
   # puts @artii.asciify('HIGH SCORES')
   sorted_score =  Score.all.sort_by {|obj| obj.score}.reverse
   top10 = sorted_score[0..9]
   # binding.pry
   rows = []
   top10.each do |each|
     rows << [each.username, each.score]
   end
   table = Terminal::Table.new :title => "HIGH SCORES", :headings => ['Username', 'Score'], :rows => rows, :style => {:width => 40, :padding_left => 3, :border_x => "=", :border_i => "x"}
   puts table
 end

 def display_hardest_question
   if Score.all.count <= 20
     puts "Play more to get the hardest question!"
   else
       q_arr = Score.all.map do |each_score|
         each_score.game_id
       end
       q_count = Hash.new(0)
       q_arr.each do |q|
         q_count[q] +=1
       end
       sorted_q = q_count.sort_by {|k,v| v}.reverse
       q_id = sorted_q[0][0]

       q_instance = Game.find_by id: q_id
       sleep(1)
       puts "\n"
       puts "Hardest Question: #{q_instance.quote}".colorize(:color => :cyan)
       puts "\n"
     end
 end


end # end of cli method
