require_relative 'person'
require_relative 'blackjack'
require_relative 'audiotest'

class Casino

  def initialize
  @person = Person.new
  @audio = Audio.new
  puts "\nWELCOME TO THE DPL CASINO!!!!"
  puts "\nYour current balance : #{@person.bank}\n\n
          What game do you want to play?"
  end

  def welcome
    @audio.playSound
    puts "\n\t 
            1) BlackJack\n
            2) Quit
            "
      case gets.to_i
          when 1
            puts "BlackJack"
            BlackJack.new(@person)
          when 2
            puts "GoodBye! See you soon!!"
            exit
          else
            puts "Invalid input. Please select from above."
            welcome
        end
        welcome
  end

end

Casino.new.welcome