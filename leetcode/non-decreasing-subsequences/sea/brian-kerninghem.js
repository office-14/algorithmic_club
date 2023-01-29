/**
 * @param {number} turnedOn
 * @return {string[]}
 */
 var readBinaryWatch = function(turnedOn) {
    let result = [];
    for(let h=0;h<12;h++){
        for(let m=0;m<60;m++){
            if((bitCount(h)+bitCount(m)) == turnedOn){
                result.push(m<10?`${h}:0${m}`:`${h}:${m}`);
            }
        }
    }

    return result;
};

var bitCount = function(n){
    let count = 0;
    while(n){
        n&=n-1;
        count++;
    }
    return count;
}