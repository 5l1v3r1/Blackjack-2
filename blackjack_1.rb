require_relative 'cardsdeck'
require_relative 'person'
#require 'pry'

class BlackJack

  
  def initialize
    @deck = Deck.new
    @cards_deck = @deck.cards
    @person = Person.new
    @player = Player.new
    playerProfile
    @player_cards = []
    @card_value = 0
    @game = true
    @quit_casino = false
    
  end

  def playerProfile
    @counter = 0
    puts "\nWelcome #{@person.name}"
    puts "\nYou have #{@person.bank} in your bank" 
    if @person.bank ==0 
      puts "\nYou should have atleast $10 balance"
      @person.bank = 10.0
    end
     startGame
  end

  def startGame
    
    @bet =0
    puts "\nMinimum Bet: 10"
    puts "\nHow much do you want to bet?"
    @bet = gets.to_i

    if @bet >= 10
        puts "\nDealer deal the cards"
        puts "\nPlayer cards are\n"
        @player_cards = [@cards_deck.sample,@cards_deck.sample]
        @deck.list_all_cards(@player_cards)
        @player_card_value =cardsValue(@player_cards)
        puts "\nPlayer card values #{@player_card_value}"
        puts "\nDealer cards are"
        @dealer_cards = [@cards_deck.sample,@cards_deck.sample]
        @deck.list_all_cards(@dealer_cards)
        @dealer_card_value =cardsValue(@dealer_cards)
        puts "\nDealer card values #{@dealer_card_value}"
        if @player_card_value == @dealer_card_value && @dealer_card_value ==21
          puts "its a PUSH!!!"
          #binding.pry
          @counter += 1
          #binding.pry
        elsif @player_card_value == 21
          @person.bank += (@bet*1.5)
          #binding.pry
          @counter += 1
          #binding.pry
          puts "\nBLACKJACK for #{@person.name}!!\nYour new balance is #{@person.bank}"
        elsif @dealer_card_value == 21
          #binding.pry
          @counter+=1
          #binding.pry
          @person.bank -= @bet
          puts "\nBLACKJACK for Dealer!!\n Your new balance is #{@person.bank}"
          
        else
          playerCardValues
          if @pfinish
            puts "player finish #{@pfinish}"
            dealerCardValues
            puts "dealer finish #{@dfinish}"
            if @pfinish || @dfinish
              continueGame
            end
          end
          
          
        end
        puts "\nNo of games #{@counter}"
          puts "Player Balance :#{@person.bank}"
          if(@counter % 10 == 0 || @person.bank == 0.0)
            puts "\nDo you wanna quit?"
            quit_choice = gets.strip.downcase
              if(quit_choice != 'no')
                puts "\nGoodBye!! See you next time"
                exit
              else
                startGame
              end
            else
              startGame
            end 
        puts "\nPlayer Balance :#{@person.bank}"
    else
      puts "\nThe minimum bet is 10. Please place 10 or more."
    end

  end

  def cardsValue(card_arr)
    card_value = 0
    value = 0
    if card_arr[0].rank == "A" && card_arr[1] == "A"
      card_value =2
    else
      card_arr.each do |card|
          if ["K","Q","J"].include? card.rank
              value = 10
          elsif card.rank.eql? "A"
            # @working_arr = @player_cards.clone
            # card.rank = aceMethod(card_arr)
            value = 11
            if card_value.between?(11,20) || card_value.between?(1,6)
              value = 1
            end
            puts "card rank for A: #{card.rank}"
          else
            value = card.rank
          end
          card_value += value.to_i
      end
    end
    card_value
  end

  def hitMethod(player)

    puts 
    if player.eql? 'player'
      @player_cards << @cards_deck.sample 
      arr =@player_cards
    else
      @dealer_cards << @cards_deck.sample 
      arr = @dealer_cards 
    end
    @deck.list_all_cards(arr)
    value = cardsValue(arr)
    if player.eql? 'player'
      @player_card_value = value
    else
      @dealer_card_value = value
    end
    if value > 21
      puts "\nYOU GOT BUSTED!!"
      return false
    else
      return true
    end
  end
 
  def dealerCardValues
    while @dealer_card_value < 17
      if !hitMethod('dealer')
        @person.bank +=@bet          
          #binding.pry
          @dfinish =false
          @counter += 1
          #binding.pry
          else
            @dfinish =true
      end
    end
    puts "\nDealer final card value #{@dealer_card_value}"
    
  end

  def playerCardValuesAfterHit
    hit = true
    while hit == true
      puts "\n#{@person.name}, Do you want to hit or stay"
      choice = gets.strip.downcase=='hit' ? 1 : 0
      if choice == 1
        if !hitMethod('player')
          puts @player_card_value
          @person.bank -=@bet
          hit = false
          #binding.pry
          @p_counter += 1
          @p_finish =false
        end
        puts "Player card values #{@player_card_value}"
      else
        hit = false
        @p_finish =true
      end
    end
    
  end

  

  def continueGame
    if @player_card_value > @dealer_card_value
      puts "\nYou Won!"
      @person.bank +=@bet
    elsif @player_card_value < @dealer_card_value && @dealer_card_value < 21
      puts "\nYou Lost!"
      @person.bank -=@bet
    elsif @player_card_value == @dealer_card_value
      puts "\nPUSH!"
    end
    #binding.pry
    @counter = @counter + 1
    #binding.pry
    
    
  end
  
end
BlackJack.new.startGame