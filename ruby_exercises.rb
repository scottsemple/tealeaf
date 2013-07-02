array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

array.each do |num|
	puts "=> #{num}"
end

array.each do |num|
	if num > 5
		puts "=> #{num}"
  end
end

array.select { |e| e.odd? }
# I see that .select returns a new array, but what is the name of that array?
# How would the selected array be accessed by the program if it isn't named?

array.push 11
array.unshift 0
array.pop
array.push 3
array.uniq!

