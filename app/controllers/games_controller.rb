require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    c = 0
    grid = params[:letters].split(' ')
    grid.each { |letter| c += 1 if params[:word].include?(letter) }

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    result = JSON.parse(open(url).read)

    @response = 'Congrats! You gave a valid word!'
    @response = 'Word does not exist' unless result['found']
    @response = 'This word cannot be made out of these letters' if c.zero?
    raise
  end
end
