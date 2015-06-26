# 1. Have detailed requirements or specifications in writen form.
# 2. Extract major nouns -> classes
# 3. Extract major verbs -> instance methodes
# 4. Group instance methods into classes

class Card
  attr_accessor :suit, :face_value

  def initialize(s, fv)
    @suit = s
    @face_value = fv
  end

  def pretty_output
    "The #{face_value} of #{find_suit}"
  end

  def to_s
    pretty_output
  end

  def find_suit
    case suit
      when 'H' then 'Hearts'
      when 'D' then 'Diamonds'
      when 'S' then 'Spades'
      when 'C' then 'Clubs'
    end
  end
end

class Deck
  attr_accessor :cards

  SUIT = ['H', 'C', 'D', 'S']
  CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize
    @cards =[]
    SUIT.each do |suit|
      CARDS.each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    deck_shuffle
  end

  def deck_shuffle
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end

  def size
    cards.size
  end
end

module Hand

  def show_hand
    puts " ----#{name}'s Hand----"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
  end

  def total
    face_values = cards.map {|card| card.face_value }

    total = 0
    face_values.each do |val|
      if val == "A"
        total += 11
      else
        total += (val.to_i == 0 ? 10 : val.to_i)
      end
  end

  #correct for Aces
    face_values.select {|val| val == "A"}.count.times do
      break if total <= 21
      total -= 10
    end
    total
  end

  def has_blackjack?
    total == 21
  end

  def add_card(new_card)
    cards << new_card
  end
end

class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def get_player_name
    puts "What is your name?"
    @name = gets.chomp
    puts "---Hello #{name} welcome to Blackjack---"
    sleep(1)
    puts "---get ready to play---"
  end
end

class Dealer
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def dealers_hand
    puts " ----Dealer's Hand----"
    puts "Dealers first card is hidden"
    puts "Dealers second card is #{cards[1]}"
  end
end

module PlayAgain
  def next_game
    while
      sleep (1)
      puts "do you want to play again, Y/N?"
      play = gets.chomp.downcase

      if !['y', 'n'].include?(play)
        puts "you must enter Y or N"
        next
      end

      if play == "n"
        exit
      end
      if play == 'y'
        game = Game.new.dealing
      end
    end
  end
end

class Game
  include PlayAgain

  attr_accessor :player, :dealer, :deck

  BLACKJACK = 21
  DEALERS_HIT_NUMBER = 17

  def initialize
    @deck = Deck.new
    @player = Player.new("player")
    @dealer = Dealer.new
  end

  def deal_cards
    player.get_player_name
    sleep (1)
    player.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    player.show_hand
    sleep (1)
    dealer.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    dealer.dealers_hand
  end

  def dealing
    deal_cards

    if player.has_blackjack?
      sleep (1)
      puts "player has hit Blackjack!, player wins!"
      next_game
    end

    while player.total < BLACKJACK
      puts "Do you want to hit Y/N?"
      hit_or_stay = gets.chomp.downcase

       if !['y', 'n'].include?(hit_or_stay)
          puts "You must enter y or n "
          next
      end

      if hit_or_stay == 'n'
        sleep (1)
        puts "you have chosen to stay"
        break
      end

      sleep (1)
      puts "#{player.name} has chosen to hit. dealing a new card."
      sleep (1)
      player.add_card(deck.deal_one)
      player.show_hand

      if player.has_blackjack?
        sleep (1)
        puts "#{player.name} has hit blackjack! #{player.name} WINS!"
        next_game
      end

      if player.total > BLACKJACK
        sleep(1)
        puts "#{player.name} has busted!"
        puts "Dealer wins!"
        next_game
      end
    end

    while dealer.total < DEALERS_HIT_NUMBER
      sleep (1)
      puts "Dealer must hit if below 17"
      sleep (1)
      puts "dealer gets a new card"
      dealer.add_card(deck.deal_one)
      dealer.show_hand
    end

      if dealer.has_blackjack?
        sleep (1)
        dealer.show_hand
        puts "Dealer has Blackjack!"
        sleep (1)
        puts "Delaer wins!"
        next_game
      end

      if dealer.total > BLACKJACK
        sleep (1)
        puts "Dealer has #{dealer.total} Dealer has busted!"
        sleep (1)
        puts "#{player.name} wins!"
        next_game
      end

      if player.total > dealer.total && dealer.total > DEALERS_HIT_NUMBER
        sleep (1)
        puts "#{player.name} has #{player.total} Dealer has #{dealer.total}, #{player.name} has won!"
        next_game
      end

      if dealer.total > player.total && dealer.total < BLACKJACK
        sleep (1)
        dealer.show_hand
        puts "Dealer has #{dealer.total}, Dealer has won!"
        next_game
      end

      if player.total == dealer.total
        sleep (1)
        puts "#{player.name} has #{player.total} dealer has #{dealer.total}"
        sleep (1)
        puts "its a tie!"
        next_game
      end
    end
end

game = Game.new.dealing
