require_relative '../config/environment'

c = CLI.new
c.welcome # TAKES IN USERNAME + CREATES NEW USER INSTANCE
c.start_game # ASKS TO PLAY GAME + SAMPLE QUOTE
c.display_high_score
# c.check_answer(guess)
puts " "
