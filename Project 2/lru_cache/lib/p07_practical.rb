require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash = HashMap.new
  string.chars.each do |ch|
    if hash.include?(ch)
      hash.delete(ch)
    else
      hash[ch] = 1
    end
  end
  hash.count < 2
end
