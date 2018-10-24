class CLI
  attr_accessor :user, :game, :score

  def initialize
    @score = 0
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
    quote = Game.all.sample.quote
    puts quote
    puts "\n"
    show_names = Game.all.map { |game| game.show }.uniq
    # ["The Office", "Seinfeld"]
    show_names.each_with_index { |name, index| puts "#{index + 1}. #{name}" }
    puts " "
    user_input_number = gets.chomp.to_i # the user's guess
    show_name = show_names[user_input_number - 1] # "The Office"
    check_answer(quote, show_name)
  end

  def check_answer(quote, answer)
    show = Game.all.find_by(quote: quote).show
    if (show == answer)
      puts "GOOD JOB"
      @score += 1
      puts "Your score is #{self.score}"
      # binding.pry
    end
  end

  # def end_game
  #   Score.new(score: @score, user: @user.id, game: @game.id)
  # end

end
