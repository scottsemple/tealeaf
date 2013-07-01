require 'pry'

def say expression
	puts "=> #{expression}"
end

say "Let's do some math."
say "What your first number?"
first_number = gets.chomp
say "What's your second number?"
second_number = gets.chomp
say "What should we do with those numbers?"
say "Type '1' for addition, '2' for subtraction, '3' for multiplication or '4' for (some strange) division."
operation = gets.chomp

if operation.to_i == 1
	say "#{first_number} plus #{second_number} equals #{first_number.to_i + second_number.to_i}."
elsif operation.to_i == 2
	say "#{first_number} minus #{second_number} equals #{first_number.to_i - second_number.to_i}."
elsif operation.to_i == 3
	say "#{first_number} times #{second_number} equals #{first_number.to_i * second_number.to_i}."
elsif operation.to_i == 4
	say "#{first_number} divided by #{second_number} equals #{first_number.to_i / second_number.to_i}."
end
