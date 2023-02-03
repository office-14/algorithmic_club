# @param {Integer[]} nums
# @return {Integer[][]}
def find_subsequences(nums)
    result_arr = find_subarray(nums[0], nums[1..-1])
    result_arr.select{|e| e.count > 1}.uniq
end

def find_subarray(current_el, other_arr)
    result = []
    result.push([current_el])
    if other_arr.count > 0
        next_result = find_subarray(other_arr[0], other_arr[1..-1])
        result += next_result
        next_result.each do |_result|
            if _result[0] >= current_el
                result.push([current_el] + _result)
            end
        end
    end
    result
end