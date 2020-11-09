require 'open-uri'
require 'json'
require 'pry-byebug'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word].upcase
    @built = built?(@word, @letters)
    @english = english?(@word)
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    checkdict = open(url).read
    dictresult = JSON.parse(checkdict)
    return dictresult["found"]
  end

  def built?(word, letters)
    word.chars.each do |char|
      if letters.include?(char.upcase)
        letters.delete_at(letters.index(char.upcase))
      else
        return false
      end
    end
    return true
  end

end
