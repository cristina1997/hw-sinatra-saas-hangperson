class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    # the letter cannot be null or a character other than letters from a-z A-Z
    if letter == nil or not letter =~ /^[a-zA-Z]$/i 
      raise ArgumentError 
    end
    
    # change letters to downcase
    letter.downcase!
    
=begin 
  If the word has the letter and the letter hasn't been guessed before 
    then add the letter to the guessed letters list.
  If the word does not include the guessed letter and the letter hasn't been guessed before 
    then add the letter to the wrong guessed letters list.
=end
    if @word.include? letter and not @guesses.include? letter
      @guesses.concat letter
      return true
    elsif not @word.include? letter and not @wrong_guesses.include? letter
      @wrong_guesses.concat letter
      return true
    else
      return false
    end
  end
  
  def word_with_guesses
    result = ''
    
=begin 
  If the player didn't guess a letter existing in the word then draw the hangman using '-'.
  If the player guessed a letter existing in the word then return the guessed word to the player.
=end
    @word.each_char do |letter|  
      result.concat '-' unless @guesses.include? letter
      result.concat letter if @guesses.include? letter
    end
    return result
  end
  
  def check_win_or_lose
    guess = word_with_guesses
    
=begin 
  If the result of the word_with_guesses() method is '-' then the player has wrong guesses, therefore the player has more chances of losing.
  If the player guessed a letter 7 times then the man is hanged and the player loses.
  If the result of the word_with_guesses() method is the correct word and the player guessed a letter less than 7 times then the player wins.
  If none of the above are true then the game continues.
=end  
    if guess == '-' or @wrong_guesses.length == 7
      :lose
    elsif guess == @word and @wrong_guesses.length < 7
      :win
    else
      :play
    end
  end
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end