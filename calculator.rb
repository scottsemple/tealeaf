require 'pry'

def say (expression)
  puts "=> #{expression}"
end

say "Let's do some math."
say 'What your first number?'
first_number = gets.chomp
say "What's your second number?"
second_number = gets.chomp
say 'What should we do with those numbers?'
say "Type '1' for addition, '2' for subtraction,"
say "'3' for multiplication or '4' for (some strange) division."
operation = gets.chomp

if operation.to_i == 1
  result = first_number + second_number
  say "#{first_number} plus #{second_number} equals #{result.to_i}."
elsif operation.to_i == 2
  result = first_number - second_number
  say "#{first_number} minus #{second_number} equals #{result.to_i}."
elsif operation.to_i == 3
  result = first_number * second_number
  say "#{first_number} times #{second_number} equals #{result.to_i}."
elsif operation.to_i == 4
  result = first_number / second_number
  say "#{first_number} divided by #{second_number} equals #{result.to_i}."
end
