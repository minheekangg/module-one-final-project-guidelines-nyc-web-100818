require 'JSON'

class CLI
  attr_accessor :user, :game, :game_score

  def initialize
    @game_score = 0
    @shows = []
  end

  def welcome
    puts "Welcome! Please enter your username"
    username = gets.chomp   #TAKES IN USERNAME
    new_user = User.find_or_create_by(username: username)
    @user = new_user
  end

  def start_game
    puts "try to match quote to the show - CHANGE THIS LATER"
    puts "\n"
    game_instance = Game.all.sample
    quote = game_instance.quote
    puts quote
    puts "\n"
    show_names = Game.all.map { |game| game.show }.uniq
    # ["The Office", "Seinfeld"]
    show_names.each_with_index { |name, index| puts "#{index + 1}. #{name}" }
    puts " "
    user_input_number = gets.chomp.to_i # the user's guess
    show_name = show_names[user_input_number - 1] # "The Office"
    puts "\n"
    check_answer(quote, show_name, game_instance)
  end

  def check_answer(quote, answer, game_instance)
    show = Game.all.find_by(quote: quote).show
    if (show == answer)
      puts "GOOD JOB"
      @game_score += 1
      @shows << show
      puts "Your score is #{self.game_score}"
      start_game

    else
      puts "UHOH! THE ANSWER IS: #{show}"
      puts "\n"
      @shows << show
      @shows.pop
      @game = game_instance.id
      end_game
      # binding.pry
      display_score(self.game_score, @shows)
      puts "\n"
    end
        display_high_score
    # binding.pry
  end

  def display_score(score, shows)
    puts "\tYour score for this game is #{score}"
      show_count = Hash.new(0)
      shows.each do |show|
        show_count[show] +=1
      end
    puts "\t ##"
    sorted_shows = show_count.sort_by {|k,v| v}.reverse
    sorted_shows.each do |show, score|
      puts "\t#{show} : #{score}"

    end
  end


  def end_game
    if Score.all.count < 1
      Score.create(score: @game_score, user_id: @user.id, game_id: @game, username: @user.username)
    else
      Score.all.each do |each|
        if self.user.id == each.user_id
          if self.game_score > each.score
              each.score = self.game_score
          end
        else
          Score.create(score: @game_score, user_id: @user.id, game_id: @game, username: @user.username)
      end
  end
end


  def display_high_score
#     sorted_score =  Score.all.sort_by {|obj| obj.score}.reverse
#     top10 = sorted_score[0..9]
#       top10.each_with_index do |top, idx|
#         puts "#{idx + 1}. #{top.username} : #{top.score}"
#       end
# binding.pry
end # end of method


end


private
# #REMOVING DUPLICATES FROM SQL
# DELETE FROM games
# WHERE id NOT IN
# 	(SELECT MIN(id) as id
# 	FROM games
# 	GROUP BY show, quote)
