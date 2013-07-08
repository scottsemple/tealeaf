# Encoding: UTF-8

# BLACKJACK

def say (expression)
  puts "=> #{expression}"
end

def deal
  card = rand(1..52) % 13
  if card == 11 || card == 12 || card == 0
    card = 10
  elsif card == 1
    card = 11
  else
    card
  end
end

player_hand = []
dealer_hand = []

player_hand << deal
dealer_hand << deal
player_hand << deal
dealer_hand << deal

def total_hand (hand)
  
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

end

player_score = total_hand(player_hand)
dealer_score = total_hand(dealer_hand)

say "You: #{player_hand[0]} and #{player_hand[1]} for a hand of #{player_score}."
say "Dealer: #{dealer_hand[0]} and #{dealer_hand[1]} for a hand of #{dealer_score}."

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

if player_score <= 21

  say "Now it's the dealer's turn."

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

  if dealer_score <= 21 && dealer_score >= player_score
    say 'Dealer wins.'
  else
    say 'You win!'
  end
  
end