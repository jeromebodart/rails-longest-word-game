require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @score = 0
    @word = params[:response]
    @letters = params[:letters].split(" ")
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    # binding.pry
    if (@word.upcase.split(""))&@letters == @word.upcase.split("")
      result = open(url).read
      user = JSON.parse(result)
      english_word = "Congratulations #{@word} is a valid English word!"
      not_english = "Sorry but #{@word} does not seem to be a valid English word...} "
      user["found"] ? @response = english_word : @response = not_english
      @score += user["length"] if user["found"]
    else
      @response = "Sorry but #{@word} can't be built out of #{@letters.join}"
    end
  end
end
