  
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
  
  arr.select{|x| x == "A"}.count.times do
    sum -= 10 if sum > 21
    end

    sum
end  

def check_for_winner(winner)
   if winner == 21
    puts "player wins!"
  end
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
puts "Dealer has: #{dealer_cards[0]} and #{dealer_cards[1]}"

player_total = calculate_total(player_cards)
dealer_total = calculate_total(dealer_cards)


p "player has total of: #{player_total}"
p "dealer has total of: #{dealer_total}"

check_for_winner(player_total)



puts "What do you want to do? hit y/n?"
choice = gets.chomp

if choice == 'y'
     player_cards << deck.pop
    player_total = calculate_total(player_cards)
    p player_cards
  puts player_total
end



puts "hit again? y/n"
choice == gets.chomp

if choice == 'y'
     player_cards << deck.pop
    player_total = calculate_total(player_cards)
    p player_cards
  puts player_total
elsif choice == 'n'
  break
end







  
  
  


#show cards







