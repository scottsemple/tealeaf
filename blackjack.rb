require 'pry'

class Card
  attr_accessor :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "#{value} of #{suit}"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    values = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
              'Jack', 'Queen', 'King', 'Ace']
    suits = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
    values.product(suits).each do |card|
      @cards << Card.new(card[0], card[1])
    end
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end
end

module Hand
  def show_hand
    puts ""
    puts "---- #{name}'s Hand ----"
    cards.each do |card|
      puts "#{card}"
    end
    puts "Total: #{total_hand}"
  end

  def total_hand
    values = cards.map { |card| card.value }

    total = 0
    values.each do |value|
      if value == 'Ace'
        total += 11
      elsif value.to_i == 0
        total += 10
      else
        total += value.to_i
      end
    end

    # Correct for Aces
    values.select { |value| value == 'Ace' }.count.times do
      if total <= 21
        break
      else
        total -= 10
      end
    end

    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total_hand > 21
  end
end

class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end
end

class Dealer
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

end

class Blackjack
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new("")
    @dealer = Dealer.new
  end

  def get_player_name
    puts ""
    puts "Let's play blackjack!"
    puts "What's your name?"
    player.name = gets.chomp
  end

  def deal_cards
    player.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    player.show_hand
    dealer.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    dealer.show_hand
  end

  def player_turn
    while player.is_busted? != true
      puts ""
      puts "Hit or stay? (Type '1' for a new card or 'Enter' to stay.)"
      response = gets.chomp
      if response.to_i == 1
        player.add_card(deck.deal_one)
        puts ""
        puts "Your new card is a #{player.cards[-1].to_s}."
        player.show_hand
          if player.is_busted? == true
            puts 'You bust.'
            play_again?
          end
      else
        break
      end
    end
  end

  def dealer_turn
    while dealer.is_busted? != true
      if dealer.total_hand <= 16
      dealer.add_card(deck.deal_one)
      puts ""
      puts "The dealer hits and gets a #{dealer.cards[-1].to_s}."
      dealer.show_hand
        if dealer.is_busted? == true
          puts 'The dealer busts.'
        end
      else
        break
      end
    end
  end

  def who_won?
    puts ""
    if dealer.is_busted? != true && dealer.total_hand >= player.total_hand
      puts 'Dealer wins.'
    else
      puts 'You win!'
    end
  end

  def play_again?
    puts ""
    puts "Would you like to play again? (Type 'y' for a new card " +
         "or 'Enter' to quit.)"
    response = gets.chomp
    if response == "y"
      game = Blackjack.new
      game.start
    else
      exit
    end
  end

  def start
    get_player_name
    deal_cards
    player_turn
    dealer_turn
    who_won?
    play_again?
  end
end

game = Blackjack.new
game.start