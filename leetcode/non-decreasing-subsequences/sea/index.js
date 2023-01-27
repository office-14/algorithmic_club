//https://leetcode.com/problems/non-decreasing-subsequences/
/**
 * @param {number[]} nums
 * @return {number[][]}
 */
 var findSubsequences = function(nums) {
    let result = new Set();
    
    for(let i=0; i<nums.length; i++){
        let newArrays = [];
        for(let res of result){
           let resArr = JSON.parse(res)
           if(nums[i]>=resArr[resArr.length-1]){
               let newArr = [...resArr];
               newArr.push(nums[i]);
               newArrays.push(newArr);
           }
        }
        for(let j=0; j<newArrays.length; j++){
            result.add(JSON.stringify(newArrays[j]));
        }
        result.add(JSON.stringify([nums[i]]));
    }
    
    return Array.from(result).map(x=>JSON.parse(x)).filter(x=>x.length>=2);
};

//findSubsequences([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]);