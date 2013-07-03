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

# Hash versus array:
# An array is an ordered, indexed list, starting with 0 for the first position.
# A hash is a collection of key:value pairs, indexed with the key value.

array = [1, 2, 3]

hash1_8 = {:a => 1, :b => 2}
hash1_9 = {a: 1, b: 2. c:3}

hash1_9[:b]

hash1_9[:d] = 4

hash1_9.delete_if {|k, v| v < 3.5}

# Yes, hash values can be arrays.
# Yes, you can have an array of hashes.