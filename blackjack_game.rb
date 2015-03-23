  
puts "Hello, welcome to Blackjack."
#need a deck
def calculate_total(hand)
  arr = hand.map{ |x| x[0] }
  
  sum = 0
  arr.each do |value|
    if value == 'A'
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end
  
  arr.select{|x| x == 'A'}.count.times do
    sum -= 10 if sum > 21
    end
  sum
end  





cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

suit = ['of Hearts', 'of Clubs', 'of Diamonds', 'of Spades']
  
deck = cards.product(suit)
deck.shuffle!

player_cards = []
dealer_cards = []


player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

puts "Player has: #{player_cards[0]} and #{player_cards[1]}"
puts "Dealer has the: #{dealer_cards[0]} and the other card is face down"

  player_total = calculate_total(player_cards)
  dealer_total = calculate_total(dealer_cards)

puts "player has total of: #{player_total}"

if player_total == 21
  puts "player has hit black jack, player wins!"
  exit
end


while player_total < 21
  puts "Do you want to hit? y/n."
  hit_or_stay = gets.chomp
  
  if !['y', 'n'].include?(hit_or_stay)
    puts "You must enter y or n "
    next
  end


if hit_or_stay == 'n'
  puts "you have chosen to stay"
  break
end
  
  puts "player has chosen to hit"
  player_cards << deck.pop
  player_total = calculate_total(player_cards)
  puts "Player got the: #{player_cards}"
  puts "you now have #{player_total}"
  
  if player_total == 21
    puts "you have Blackjack, player wins!"
  end
  
  if player_total > 21
    puts "player has busted"
    puts "House wins!"
    exit
  end
end


while dealer_total < 17
  puts "Dealer must hit if below 17"
  dealer_cards << deck.pop
  dealer_total = calculate_total(dealer_cards)
  puts "Dealer has the: #{dealer_cards}"
  puts "dealers new total is #{dealer_total}"
  
  if dealer_total > 21
    puts "dealer has busted player wins!"
    exit
  end
end

if player_total > dealer_total
  puts "player has #{player_total} and dealer has #{dealer_total}"
  puts "player wins!"
end

if player_total == dealer_total
  puts "player has #{player_total} and dealer has #{dealer_total}"
  puts "Its a tie!"
end

if dealer_total > player_total
  puts "player has #{player_total} and dealer has #{dealer_total}"
  puts "House wins!"
  exit
end

  