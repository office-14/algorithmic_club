# @param {String} s
# @param {String} p
# @return {Integer[]}
def find_anagrams(s, p)
    result = []
    if p.length > s.length
        return result
    end
    alphabet = {"a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5, "g" => 6, "h" => 7, "i" => 8, "j" => 9, "k" => 10, "l" => 11, "m" => 12, "n" => 13, "o" => 14, "p" => 15, "q" => 16, "r" => 17, "s" => 18, "t" => 19, "u" => 20, "v" => 21, "w" => 22, "x" => 23, "y" => 24, "z" => 25}

    current_letters_counter = Array.new(26, 0)
    p_letters_counter = Array.new(26, 0)  
    p_length = p.length
    for i in (0..p.length-1)
        l = p[i]
        p_letters_counter[alphabet[l]] += 1
    end
    for i in (0..p.length-1)
        l = s[i]
        current_letters_counter[alphabet[l]] += 1
    end
    if p_letters_counter == current_letters_counter
        result.push(0)
    end
    start_pos = 0
    for i in (p.length..s.length-1)
        current_letters_counter[alphabet[s[start_pos]]] -= 1
        current_letters_counter[alphabet[s[i]]] += 1
        start_pos += 1
        if p_letters_counter == current_letters_counter
            result.push(start_pos)
        end
    end
    result
end