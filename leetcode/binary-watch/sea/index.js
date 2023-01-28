/**
 * @param {number} turnedOn
 * @return {string[]}
 */
 var readBinaryWatch = function(turnedOn) {
    if(turnedOn === 0){
        return ["0:00"];
    }
    const result = [];
    let midnight = []
    for(let i=0;i<10;i++){
        midnight.push(false);
    }
    let timeArrays = [];
    for(let i=0;i<10;i++){
        let timeArray = [...midnight];
        timeArray[i] = true;
        if(timeArray.filter(x=>x).length == turnedOn){
            let time = convertToTime(timeArray);
            if(time !== -1){
                result.push(time);
            }
        }
        else {
            timeArrays.push(timeArray);
        }
        if(i<9){
            let j=i+1;
            let k=0;
            let arraysToAdd = [];
            while(k < timeArrays.length){
                let timeArray = [...timeArrays[k]];
                timeArray[j] = true;
                if(timeArray.filter(x=>x).length == turnedOn){
                    let time = convertToTime(timeArray);
                    if(time !== -1){
                        result.push(time);
                    }
                }
                else {
                    arraysToAdd.push(timeArray);
                }
                k++;
            }
            for(let timeArray of arraysToAdd){
                timeArrays.push(timeArray);
            }
        }
        
    }

    return result;
};
var convertToTime = function(timeArray){
    let h=0; let m = 0;
    for(let i=0;i<4;i++){
        h+=timeArray[i]*Math.pow(2, 3-i);
    }
    if(h>11){
        return -1;
    }
    for(let i=0;i<6;i++){
        m+=timeArray[i+4]*Math.pow(2,5-i);
    }
    if(m>59){
        return -1;
    }
    if(m<10) return `${h}:0${m}`;
    return `${h}:${m}`;
};