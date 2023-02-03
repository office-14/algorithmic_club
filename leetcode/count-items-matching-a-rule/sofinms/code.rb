# @param {String[][]} items
# @param {String} rule_key
# @param {String} rule_value
# @return {Integer}
def count_matches(items, rule_key, rule_value)
    counter = 0
    types = {
        'type' => 0,
        'color' => 1,
        'name' => 2
    }
    items.each do |item|
        if types[rule_key] && item[types[rule_key]] == rule_value
            counter += 1
        end
    end
    counter
end