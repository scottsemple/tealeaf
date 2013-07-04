# Encoding: UTF-8

# BLACKJACK

# PROCESS:
# => Shuffle the cards;
# => Deal the cards to the player and the dealer;
# => Total the cards for each hand;
# =>    Watch for face cards that are 10 and aces which can be 1 or 11;
# => Prompt the user if they would like a new card;
# =>    Total the new hand and prompt again until they bust or decline a card;
# => Automate the process for the dealer to get new cards based on rules:
# =>    Hit on 16, hold on greater than 16.
# => Compare hands and decide on the winner.
# =>    Dealer wins on 21, otherwise compare the two hands to determine the
# =>    winner.

require 'pry'

def say (expression)
  puts "=> #{expression}"
end

def deal
  card = rand(1..52) % 13
  if card == 11 || card == 12 || card == 13
    card = 10
  elsif card == 0
    card = 11 # I'll deal with the || 1 option later.
  else
    card
  end
end

first_card = deal
second_card = deal
player_hand = first_card + second_card

say "You have #{first_card} and #{second_card} for a hand of #{player_hand}."

while player_hand < 21
  say "Hit or stay? (Type '1' for a new card or 'Enter' to stay.)"
  response = gets.chomp
  if response.to_i == 1
    new_card = deal
    say "Your new card is #{new_card}."
    player_hand = player_hand + new_card
      if player_hand > 21
        say 'You bust.'
        break
      else
        say "Your hand is now worth #{player_hand}."
      end
  else
    break
  end
end

if player_hand == 21
  say 'Congratulations.'
end

dealer_first = deal
dealer_second = deal
dealer_hand = dealer_first + dealer_second

say "The dealer has #{dealer_first} and #{dealer_second} for #{dealer_hand}."

# Why doesn't this stop here if the player busts?
# What do I need to change about the while statement so that the following
#    doesn't execute?
while dealer_hand < 21 && player_hand <= 21
  if dealer_hand <= 16
    new_card = deal
    say "The dealer hits and gets a #{new_card}."
    dealer_hand = dealer_hand + new_card
    if dealer_hand > 21
      say 'The dealer busts.'
    else
      say "The dealer has #{dealer_hand}."
    end
  else
    break
  end
end

# Same problem: What do I need to add to the while statements so busts stop the
#    program?
if dealer_hand <= 21 && player_hand <= 21 && dealer_hand >= player_hand
  say 'Dealer wins.'
else
  say 'You win!'
end
