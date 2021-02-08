require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    until @letters.length == 10
      @letters << ('A'..'Z').to_a.sample
    end
    @letters.flatten
  end

  def score
    @score = params[:game]
    @letters = params[:letters].split(" ")
    @url = "https://wagon-dictionary.herokuapp.com/#{@score}"
    @word_serialized = open(@url).read
    @word = JSON.parse(@word_serialized)

    @result = @score.upcase.split(//)
    @test_one = []
    @result.each do |letter|
      if @result.count(letter) <= @letters.count(letter)
        @test_one << 'true'
      else
        @test_one << 'false'
      end
    end
    if @test_one.include?('false')
      @test_one = false
    else
      @test_one = true
    end
    
    @test_two = @word['found']

    if @test_one == false
      @push = "Sorry but #{@score.upcase} can't be built out of #{@letters}"
    elsif @test_two && @test_one
      @push = "Congratulation, #{@score.upcase} is a valid English word!"
    else
      @push = "Sorry but #{@score.upcase} is not a valid English word..."
    end
  end
end
