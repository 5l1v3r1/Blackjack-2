require 'deck-of-cards'
require_relative 'generic'
require_relative 'dealer'
require 'colorize'
#require 'pry'

class Player 
  attr_accessor :p_finish, :player_cards, :bet
  def initialize(person,bet)
    @generic = Generic.new
    @deck = DeckOfCards.new
    @cards_deck = @deck.cards
    @player_cards = []
    @player_card_value = 0
    @p_finish = true
    @person = person
    @bet = bet
  end
  
  def set_player_cards_value(p_value)
    @player_card_value = p_value
  end
  
  def get_player_cards_value
    return @player_card_value 
  end


  def initialCards
    puts "\nPlayer cards are\n"
    @player_cards = @generic.list_all_cards([],get_player_cards_value,'player')
    set_player_cards_value(@generic.cardsValue(@player_cards).to_i)
    puts "\nPlayer card values #{get_player_cards_value}".colorize(:cyan)
  end

  def playerCardValues(bet)
    p_counter = 0
    hit = true
    hit_count =0 
    while hit == true
      if hit_count <= 0 && (9..11).to_a.include?(get_player_cards_value)
        puts "\n#{@person.name.capitalize}, Do you want to Hit(H) | Stay(S) | Double Down(D)".colorize(:cyan)
      else
        puts "\n#{@person.name.capitalize}, Do you want to Hit(H) | Stay(S) ".colorize(:cyan)
      end
      choice = gets.strip.upcase

      #if choice == 1
      case choice
      when 'H'
        hit_count +=1
        @player_cards << @cards_deck.sample 
        result_hash = @generic.hitMethod(@player_cards,get_player_cards_value)
        set_player_cards_value(result_hash[:card_val].to_i)
        if !result_hash[:busted]
          puts "\n #{@person.name.capitalize} GOT BUSTED!!".colorize(:red)
          @person.bank -=@bet
          hit = false
          #binding.pry
          p_counter = 1
          @p_finish =false
          #binding.pry
        end
        puts "Player card values #{get_player_cards_value}".colorize(:cyan)
      when 'D'
        @bet +=@bet
        puts "\n Your bet is : #{@bet}"
        @player_cards << @cards_deck.sample 
        result_hash = @generic.hitMethod(@player_cards,get_player_cards_value)
        set_player_cards_value(result_hash[:card_val].to_i)
        hit = false
        @p_finish =true
        puts "Player card values #{get_player_cards_value}".colorize(:cyan)
      when 'S'
        hit = false
        @p_finish =true
      end
    end
    return p_counter
  end

end