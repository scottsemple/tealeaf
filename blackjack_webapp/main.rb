require 'rubygems'
require 'sinatra'

set :sessions, true

helpers do
  def total_hand(cards)
    values = cards.map { |card| card[0] }

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
end

get '/' do
  if session[:player_name]
    redirect "/game"
  else
    redirect "/new_player"
  end
end

get "/new_player" do
  erb :new_player
end

post "/new_player" do
  session[:player_name] = params[:player_name]
  redirect "/game"
end

get "/game" do
  # deck
  values = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
            'Jack', 'Queen', 'King', 'Ace']
  suits = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
  session[:deck] = values.product(suits).shuffle!

  # deal_cards
  session[:player_hand] = []
  session[:dealer_hand] = []
  session[:player_hand] << session[:deck].pop
  session[:dealer_hand] << session[:deck].pop
  session[:player_hand] << session[:deck].pop
  session[:dealer_hand] << session[:deck].pop

  erb :game
end

post "/game/player/hit" do
  session[:player_hand] << session[:deck].pop
  if total_hand(session[:player_hand]) > 21
    @error = "Sorry, you busted."
  end

  erb :game
end

post "/game/dealer" do
  while total_hand(session[:dealer_hand]) < 21
    if total_hand(session[:dealer_hand]) <= 16
      session[:dealer_hand] << session[:deck].pop
    else
      break
    end
  end

  erb :game

  redirect '/game/winner'
end

get "/game/winner" do
  if total_hand(session[:dealer_hand]) > 21
    @success = 'The dealer busts. You win!'
  elsif total_hand(session[:dealer_hand]) >= total_hand(session[:player_hand])
    @error = 'Sorry... Dealer wins.'
  else
    @success = 'Congratulations! You win!'
  end

  erb :game
end
