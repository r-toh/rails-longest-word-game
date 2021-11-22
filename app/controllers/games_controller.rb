require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    # to display a new random grid and a form
     @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    # The form will be submitted (with POST)
    @word = params[:score]
    @lettersgiven = params[:lettersgiven]
    @response = ""

    if first_check
      # parse API
      url = 'https://wagon-dictionary.herokuapp.com'
      real_words = URI.open(url).read
      dictionary = JSON.parse(real_words)

      if dictionary["found"] = true
        @response = "congrats! #{@word} is a valid word!"
      else
        @response = "sorry #{@word} is an invalid word"
      end
    else
      @response = "sorry, #{@word} cant be build out of #{@lettersgiven}"
    end

  end

  private
  def first_check
  # check if word uses oNLY letters
    word_array = @word.chars
    word_array.all? do |char|
      @lettersgiven.include?(char)
    end
    # raise
  end


end

# score params = => #<ActionController::Parameters {"score"=>"bison", "authenticity_token"=>"kI8NFxUjEZ7wlHD-J3ewhv69_05boM8h3-gT8RJPjOr-JX7fW_gkPnKaRfLkDmc02WpPjX6xutaqg96RGtEZqg", "controller"=>"games", "action"=>"score"} permitted: false>
