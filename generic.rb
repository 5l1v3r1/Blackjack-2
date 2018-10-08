require 'deck-of-cards'

class Generic
  def initialize
    @cards_deck = DeckOfCards.new
  end

  def list_all_cards(arr,value,human)
    if value ==0
      arr= [@cards_deck.cards.sample,@cards_deck.cards.sample]
    end
   if human == 'dealer' && value == 0 
      puts "#{arr[0].rank} of #{arr[0].suit}"
   else
      arr.each do |card| 
        puts "#{card.rank} of #{card.suit}"
      end
    end
    arr
  end

  def cardsValue(card_arr)
    card_value = 0
    value = 0
    
      card_arr.each do |card|
          if ["King","Queen","Jack"].include? card.rank
              value = 10
          elsif card.rank.eql? "Ace"
            value = 11
            if card_value.between?(11,20) || card_value.between?(1,6)
              value = 1
            end
          else
            value = card.rank
          end
          card_value += value.to_i
      end
    
    card_value
  end

  def hitMethod(arr,value)
    result ={}
    puts 
    arr =list_all_cards(arr,value,"")
    value = cardsValue(arr)
    if value > 21
      puts "\nYOU GOT BUSTED!!"
      return {card_val:value,busted:false}
    else
      return {card_val:value,busted:true}
    end
  end
end
