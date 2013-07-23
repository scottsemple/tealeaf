require 'rubygems'
require 'sinatra'

set :sessions, true

BLACKJACK_AMOUNT = 21
MINIMUM_STAY_AMOUNT = 17
STARTING_BANKROLL = 500

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
      if total <= BLACKJACK_AMOUNT
        break
      else
        total -= 10
      end
    end

    total
  end

  def card_image(card)
    "<img class='img-polaroid' src='/images/cards/#{card[1]}_#{card[0]}.jpg' />"
  end

  def play_again?
    'Would you like to play again? <a href="/bet">Yes</a> |
    <a href="/game_over">No</a>'
  end
end

before do
  @show_hit_or_stay_buttons = true
end

get '/' do
  if session[:player_name]
    redirect "/game"
  else
    redirect "/new_player"
  end
end

get "/new_player" do
  session[:bankroll] = STARTING_BANKROLL
  erb :new_player
end

post "/new_player" do
  if params[:player_name].empty?
    @error = "Please enter your name and resubmit."
    halt erb(:new_player)
  end

  session[:player_name] = params[:player_name]
  redirect "/bet"
end

get "/bet" do
  if session[:bankroll] == 0
    @error = "Nice try... You're out of money.<br />
    Time to <a href='/new_player'>start a new game</a>?"
  end

  session[:bet] = nil
  erb :bet
end

post "/bet" do
  if params[:amount].nil? || params[:amount].to_i == 0
    @error = "Please make a bet."
    halt erb(:bet)
  elsif params[:amount].to_i > session[:bankroll]
    @error = "The bet amount cannot be greater than #{session[:bankroll]}."
    halt erb(:bet)
  else
    session[:bet] = params[:amount].to_i
    redirect "/game"
  end

end

get "/game" do
  session[:turn] = session[:player_name]

  # deck
  values = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
            'Jack', 'Queen', 'King', 'Ace']
  suits  = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
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
  if total_hand(session[:player_hand]) > BLACKJACK_AMOUNT
    session[:bankroll] -= session[:bet]
    @error = "<strong>Sorry, you busted with
      #{total_hand(session[:player_hand])}.</strong><br />#{play_again?}"
    @show_hit_or_stay_buttons = false
  end

  erb :game
end

get "/game/dealer" do
  session[:turn] = "dealer"

  @show_hit_or_stay_buttons = false

  dealer_total = total_hand(session[:dealer_hand])

  if dealer_total >= MINIMUM_STAY_AMOUNT
    redirect "/game/winner"
  else
    @show_dealer_hit_button = true
  end

  erb :game
end

post "/game/dealer/hit" do
  session[:dealer_hand] << session[:deck].pop
  redirect "/game/dealer"
end


get "/game/winner" do
  @show_hit_or_stay_buttons = false

  dealer_total = total_hand(session[:dealer_hand])
  player_total = total_hand(session[:player_hand])

  if dealer_total > BLACKJACK_AMOUNT
    session[:bankroll] += session[:bet]
    @success = "<strong>The dealer busts. You win!</strong><br />#{play_again?}"
  elsif dealer_total >= player_total
    session[:bankroll] -= session[:bet]
    @error = "<strong>Sorry... Dealer wins with #{dealer_total}.
    (You had #{player_total}.)</strong><br />#{play_again?}"
  else
    session[:bankroll] += session[:bet]
    @success = "<strong>Congratulations! You win with #{player_total}!
    (Dealer had #{dealer_total}.)</strong><br />#{play_again?}"
  end

  erb :game
end

get "/game_over" do
  erb :game_over
end