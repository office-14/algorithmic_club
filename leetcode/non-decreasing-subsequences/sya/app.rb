# @param {Integer[]} nums
# @return {Integer[][]}
def find_subsequences(nums)
    res = []
    (2..nums.size).each do |len|
        valids = nums.combination(len).to_a
        valids = valids.select{|el| el.each_cons(2).all?{|left, right| left <= right}}
        res += valids
    end

    res.uniq
end