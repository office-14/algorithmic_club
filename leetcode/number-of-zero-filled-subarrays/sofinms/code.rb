# @param {Integer[]} nums
# @return {Integer}
def zero_filled_subarray(nums)
    prev_zero = 1
    counter = 0
    nums.each do |num|
        if num == 0
            counter += prev_zero
            prev_zero += 1
        else
            prev_zero = 1
        end
    end
    counter
end