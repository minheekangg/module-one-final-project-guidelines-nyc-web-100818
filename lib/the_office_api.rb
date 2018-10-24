
require 'json'
require 'pry'
require 'nokogiri'
require 'rest-client'

def get_data
#adding nokogiri trying to parse information
# #the office quote
office = Nokogiri::HTML(RestClient.get("http://www.tv-quotes.com/shows/the-office-us/seasons/8.html"))
# parsed_page = JSON.parse(office)
binding.pry

parsed_page
end
