puts "please enter the first number"

number1 = gets.chomp.to_i

puts "please enter the type of calculation eg. add, multiply, divide"
symbol = gets.chomp

puts "please enter you second number"

number2 = gets.chomp.to_i

if symbol == ("add")
  puts "The answer is #{number1 + number2}"
  elsif symbol == ("multiply")
  puts "the answer is #{number1 * number2}"
  elsif symbol == ("divide")
  puts "The answer is #{number1.to_f / number2.to_f}"
  elsif symbol == "subtract"
  puts "The answer is #{number1 - number2}"
end

