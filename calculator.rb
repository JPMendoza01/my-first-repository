puts "please enter the first number"

number1 = gets.chomp.to_i

puts "please enter the type of calculation eg. add, multiply, divide"
symbol = gets.chomp

puts "please enter you second number"

number2 = gets.chomp.to_i

if symbol == ("add")
  puts "The awswer is #{number1 + number2}"
  elsif symbol == ("multiply")
  puts "the awswer is #{number1 * number2}"
  elsif symbol == ("divide")
  puts "The awnswer is #{number1 / number2}"
end

