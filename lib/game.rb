# require 'pry'

class Game < ActiveRecord::Base
  has_many :users
  has_many :users, through: :scores




  # def show_quote
  #   Score.all.
  # end

end
