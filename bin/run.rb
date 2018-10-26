require_relative '../config/environment'


c = CLI.new
c.welcome # TAKES IN USERNAME + CREATES NEW USER INSTANCE
c.start_game # ASKS TO PLAY GAME + SAMPLE QUOTE


# @cursor = TTY::Cursor
# @size = TTY::Screen.size # => [height, width]
# @height = @size[0]
# @width = @size[1]
#
# def move_cursor_to_required_coordinates(text)
#  x = (@size[1] - text.length) / 2
#  y = (@size[0]) / 2
#  print @cursor.move_to(x, y)
# end
#
# def centered_text(text)
#  move_cursor_to_required_coordinates(text)
#  puts text
# end
#
# centered_text(c.welcome)
