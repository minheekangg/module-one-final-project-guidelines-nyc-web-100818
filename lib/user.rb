# require 'pry'

class User < ActiveRecord::Base
  has_many :games
  has_many :games, through: :scores

  #
  # def create_user(username)
  #   User.create(username: username)
  # end

end
