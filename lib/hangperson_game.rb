class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    # the letter cannot be null or a character other than letters from a-z A-Z
    if letter == nil or not letter =~ /^[a-zA-Z]$/i or not String(letter)
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
    if word.include? letter and not @guesses.include? letter
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
