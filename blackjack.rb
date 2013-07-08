# Extract the major nouns out of specifications:
#   Card, Deck, Hand, Dealer, Player
# Organize behaviors and states into the classes

# CARDS, DECKS AND HANDS

class Card
  attr_accessor :value, :suit

  # STATE: Each card has a Value and a Suit
  def initialize (value, suit)
    @suit = suit
    @value = value
  end

  # BEHAVIOR: Each card can be described (to_s).
  def to_s
    "#{value} of #{suit}"
  end
end

class Deck
  attr_accessor :cards

  # STATE: Each deck has 52 cards, one for each value and suit combination
  def initialize
    @cards = []
    values = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13')
    suits  = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
    values.product(suits).each do |arr|
      self.cards << Card.new(arr[0], arr[1])
    end
  end

  # BEHAVIOR: A Deck can be shuffled
  def shuffle

  end
end

class Hand
  attr_accessor :cards

  # STATE: Each Hand starts with two cards
  def initialize
    @cards = []
  end

  # BEHAVIOR: A Hand can be dealt
  def deal_cards

  end

  # BEHAVIOR: A Hand can be hit
  def hit

  end

  # BEHAVIOR: A Hand can be described
  def to_s
    "#{cards}"
  end

  # BEHAVIOR: A Hand can be totaled
  def total_hand
=begin
    total = 0

    hand.each do |card|
      total += card
    end

    hand.select { |e| e == 11 }.count.times do
      if total > 21
        total -= 10
      end
    end
    
    total
=end
  end
end

# PLAYER PLAY

class Player 
  attr_accessor :name, :hand

  # STATES: A Player starts with a name and two cards
  def initialize
    @name = name
    @hand = @hand
  end

  # BEHAVIOR: A Player can have a turn
  def player_turn
=begin
    while player_score < 21
      say "Hit or stay? (Type '1' for a new card or 'Enter' to stay.)"
      response = gets.chomp
      if response.to_i == 1
        new_card = deal
        player_hand << new_card
        say "Your new card is #{new_card}."
        player_score = total_hand(player_hand)
          if player_score > 21
            say 'You bust.'
            break
          else
            say "Your hand is now worth #{player_score}."
          end
      else
        break
      end
    end
=end
  end
end

# DEALER PLAY

class Dealer
  attr_accessor :hand

  def initialize
    @hand = @hand
  end

  def dealer_turn
=begin
    while dealer_score < 21
      if dealer_score <= 16
        new_card = deal
        dealer_hand << new_card
        say "The dealer hits and gets a #{new_card}."
        dealer_score = total_hand(dealer_hand)
        if dealer_score > 21
          say 'The dealer busts.'
        else
          say "The dealer has #{dealer_score}."
        end
      else
        break
      end
    end
=end
  end
end

# GENERAL GAME STRUCTURE

class Blackjack
  attr_accessor

  def initialize
    @deck = Deck.new
    @player = Player.new ("Scott")
    @dealer = Dealer.new
    @hand = Hand.new
  end

  def start
    deal_cards
    # say "You: #{player_hand[0]} and #{player_hand[1]} for a hand of #{player_score}."
    # say "Dealer: #{dealer_hand[0]} and #{dealer_hand[1]} for a hand of #{dealer_score}."
    player_turn
    # if player_score <= 21
    #   say "Now it's the dealer's turn."
    # end
    dealer_turn
    who_won?
    play_again?
  end

  def deal_cards

  end

  def who_won
=begin
  if dealer_score <= 21 && dealer_score >= player_score
    say 'Dealer wins.'
  else
    say 'You win!'
  end
=end
  end

end

game = Blackjack.new
game.start
