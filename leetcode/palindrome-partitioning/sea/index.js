//https://leetcode.com/problems/palindrome-partitioning/
/**
 * @param {string} s
 * @return {string[][]}
 */
 var partition = function(s) {
    let result = [[s[0]]];
    for(let i=1; i<s.length;i++){
        let n = result.length;
        let j = 0;
        while(j<n){
            let resultElem = result[j];
            let lastElem = resultElem[resultElem.length-1];
            let newArr = [...resultElem];
            newArr[newArr.length-1] = lastElem+s[i];
            result.push(newArr);
            resultElem.push(s[i]);
            j++;
        }
    }
    return result.filter(subarray=>subarray.every(isPolindrom));
};

function isPolindrom(s){
    let i=0;
    while(i<Math.floor(s.length/2)){
        if(s[i] !== s[s.length-i-1]){
            return false;
        }
        i++;
    }
    return true;
}

//partition('aabbaa');