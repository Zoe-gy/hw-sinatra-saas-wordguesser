class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(word_letter)
    if (!word_letter) || (word_letter=="") || (letter= /[^A-Za-z]/ )
        raise ArugmentError
    word_letter=word_letter.downcase()
    if @guesses.index(word_letter) || @wrong_guesses.index(word_letter)
        return false
    if word.index(word_letter)
        @guesses << letter
    else
        @wrong_guesses << letter
    end
  end

  def word_with_guesses()
    temp_letter = " "
    for i in @word.chars
        if @guesses.include? i
            temp_letter = temp_letter + i
        else
            temp_letter = temp_letter + "-"
        end
    end
    return temp_letter
  end

  def check_win_or_lose()
    if @word_with_guesses == @word and @wrong_guesses.length < 7
        return ":win"
    elsif @wrong_guesses.length >= 7
        return ":lose"
    else
        return ":play"
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
