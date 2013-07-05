# Encoding: UTF-8

# BLACKJACK

def say (expression)
  puts "=> #{expression}"
end

def deal
  card = rand(1..52) % 13
  if card == 11 || card == 12 || card == 13
    card = 10
  elsif card == 0
    card = 11
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

if player_hand <= 21

  say "Now it's the dealer's turn."
  
  dealer_first = deal
  dealer_second = deal
  dealer_hand = dealer_first + dealer_second

  say "The dealer has #{dealer_first} and #{dealer_second} for #{dealer_hand}."

  while dealer_hand < 21
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

  if dealer_hand <= 21 && dealer_hand >= player_hand
    say 'Dealer wins.'
  else
    say 'You win!'
  end

end
