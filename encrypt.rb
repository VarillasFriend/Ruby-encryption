@letter_value = {
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7,
    'i' => 8,
    'j' => 9,
    'k' => 10,
    'l' => 11,
    'm' => 12,
    'n' => 13,
    'o' => 14,
    'p' => 15,
    'q' => 16,
    'r' => 17,
    's' => 18,
    't' => 19,
    'u' => 20,
    'v' => 21,
    'w' => 22,
    'x' => 23,
    'y' => 24,
    'z' => 25,
    ' ' => 26,
    '?' => 27,
    ',' => 28,
    '.' => 29
}

def caesar_cipher(message, key)
    return_message = ''
    message_array = []

    message.length.times do |time|
        message_array << message[time]
    end

    message_array.each do | char |
        if @letter_value[char.downcase]
            char2 = @letter_value.key((@letter_value[char.downcase] + key) % 30)
        else 
            char2 = char
        end
        return_message += char.downcase != char ? char2.upcase : char2
    end

    return return_message
end

def caesar_decipher(message, key)
    return_message = ''
    message_array = []

    message.length.times do |time|
        message_array << message[time]
    end

    message_array.each do | char |
        if @letter_value[char.downcase]
            char2 = @letter_value.key((@letter_value[char.downcase] - key) % 30)
        else 
            char2 = char
        end
        return_message += char.downcase != char ? char2.upcase : char2
    end

    return return_message
end

def brute_force(message, brute_force_times)
    character_frequencies = []

    @letter_value.length.times do | time |
        character_frequencies << message.count(@letter_value.key(time))
    end

    return_string = 'Most likely: '

    brute_force_times.times do | time |
        max = character_frequencies.max
        key = character_frequencies.find_index(max) - @letter_value['e']

        if time == 0
            return_string += "\n #{caesar_decipher(message, key)} \n Key: #{key}"
        else
            return_string += "\n \n or \n #{caesar_decipher(message, key)} \n Key: #{key}"
        end

        character_frequencies[character_frequencies.find_index(max)] = 0
    end
    
    return return_string
end

def vigenere_cipher(message, key)
    return_message = ''
    message_array = []
    key_array = []

    message.length.times do |time|
        message_array << message[time]
    end

    key.length.times do |time|
        key_array << key[time].downcase
    end

    selected = 0

    message_array.each do |char|
        char2 = @letter_value.key((@letter_value[char.downcase] + @letter_value[key_array[selected]]) % 30)
        return_message += char.downcase != char ? char2.upcase : char2

        if selected == key_array.length - 1
            selected = 0
        else
            selected += 1
        end
    end

    return return_message
end

def vigenere_decipher(message, key)
    return_message = ''
    message_array = []
    key_array = []

    message.length.times do |time|
        message_array << message[time]
    end

    key.length.times do |time|
        key_array << key[time].downcase
    end

    selected = 0

    message_array.each do |char|
        char2 = @letter_value.key((@letter_value[char.downcase] - @letter_value[key_array[selected]]) % 30)
        return_message += char.downcase != char ? char2.upcase : char2

        if selected == key_array.length - 1
            selected = 0
        else
            selected += 1
        end
    end

    return return_message
end

puts "Cipher:"
puts "[1] Caesar Cipher"
puts "[2] Vigenère Cipher"
cipher = gets.chomp

puts "Encryption:"
puts "[1] Encrypt"
puts "[2] Decrypt"

if cipher.include?('1')
    puts "[3] Brute Force"
end

encryption = gets.chomp

unless encryption.include?('3')
    print "Key: "
    if cipher.include?('2')
        key = gets.chomp
    else
        key = Integer(gets.chomp)
    end
end

print "Message: "
message = gets.chomp

brute_force_times = 3

output = if cipher.include?('1')
    if encryption.include?('1')
        caesar_cipher(message, key)
    elsif encryption.include?('2')
        caesar_decipher(message, key)
    elsif encryption.include?('3')
        brute_force(message, brute_force_times)
    end
else 
    if encryption.include?('1')
        vigenere_cipher(message, key)
    elsif encryption.include?('2')
        vigenere_decipher(message, key)
    end
end

puts output