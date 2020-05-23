import UIKit

var str = "Hello, playground"
//1. merge alternate string
func mergeString(a: String, and b: String) -> String {
  // base case
  if (a.isEmpty || b.isEmpty) {
    return a + b
  }
  
  // convert to char array
  var aArr = Array(a).map { String($0) }
  var bArr = Array(b).map { String($0) }
  
  // make two array the same length
  let diff = abs(aArr.count - bArr.count)
  let holders = Array.init(repeating: "", count: diff)
  if aArr.count > bArr.count {
    bArr.append(contentsOf: holders)
  } else {
    aArr.append(contentsOf: holders)
  }
  
  let result = zip(aArr, bArr)
    .compactMap { $0 }
    .map { $0.0 + $0.1 }
    .reduce("", +)
  
  return result
}

print(mergeString(a: "abc", and: "def"))

//+++++++++++++++++++++++++++++++++++++++

//another approach
func mergeStrings(a: String, b: String) -> String {
    // base case
    if (a.isEmpty || b.isEmpty) {
        return a + b
    }
    
    // convert to char array
    var arrForFirstString = Array(a).map { String($0) }
    var arrForSecondString = Array(b).map { String($0) }
    
    // make two array the same length
    let difference = abs(arrForFirstString.count - arrForSecondString.count)
    let tempArray = Array.init(repeating: "", count: difference)
    if arrForFirstString.count > arrForSecondString.count {
        arrForSecondString.append(contentsOf: tempArray)
    } else {
        arrForFirstString.append(contentsOf: tempArray)
    }
    
    let resultZip = zip(arrForFirstString, arrForSecondString)
    
    let resultCompactMap = resultZip.compactMap{$0}
    let resultMap = resultCompactMap.map{$0.0 + $0.1 }
    let resultReduce = resultMap.reduce("", +)
    return resultReduce
}
//+++++++++++++++++++++++++++++++++++++++
//2.slowest key
func slowestKey(keyTimes: [[Int]]) -> Character {
    // Write your code here
  let str = "abcdefghijklmnopqrstuvwxyz"
  let alphabetList = Array(str)
  
    var tStart = 0
    var maxT = (0,"")
  keyTimes.map {
    let T = $0[1] - tStart
    let c = alphabetList[$0[0]]
    if T > maxT.0 { maxT = (T, String(c)) }
    tStart = $0[1]
  }
    return Character(String(maxT.1))
}
print(slowestKey(keyTimes: [[0, 2], [1, 5], [0, 9], [2, 15]])) //initial time is 0, 2-0 = 2. 5-2 = 3. 9-5 = 4. 15-9 = 6. Now see 6 is larget. also in [2,15] the key is c. Hence c is answer
//c
//+++++++++++++++++++++++++++++++++++++++

//3. multiplication count leaas a input , K
func countSubarraysLessThanK(numbers: [Int], k: Int) -> Int {
    var mulResult = 1
    var endResult = 0
    var firstValue = 0
    
    for lastValue in 0..<numbers.count{
        mulResult *= numbers[lastValue];
        
        while firstValue < lastValue, mulResult > k{
            mulResult /= numbers[firstValue]
            firstValue += 1
        }
        
        if mulResult <= k {
            let offset = lastValue - firstValue + 1;
            endResult += offset
        }
    }
    return endResult
}

print(countSubarraysLessThanK(numbers: [1,2], k: 2))//1*1 <=2 Yes , 1*2 <=2 yes. 2*1 <= 2 yes, 2*2 = 4 !<=2. Thus 3 ans
print(countSubarraysLessThanK(numbers: [1,2,3], k: 2))
print(countSubarraysLessThanK(numbers: [1,2,3,4], k: 2))

print(countSubarraysLessThanK(numbers: [1,2], k: 1))
print(countSubarraysLessThanK(numbers: [4,5], k: 3)) //4*4 <=3 ? false, 4*5 || 5*4 <=3 ? false. Thus 0 ans
print(countSubarraysLessThanK(numbers: [11], k: 2))

//+++++++++++++++++++++++++++++++++++++++


//4. q4 evergreen fizzBuzz problem
func fizzBuzz(n: Int) {
    for i in 1...n {
        var printVal = ""
        if i % 3 == 0 {
            printVal.append("Fizz")
        }
        if i % 5 == 0 {
            printVal.append("Buzz")
        }
        if i % 3 != 0 && i % 5 != 0 {
            printVal.append(String(i))
        }
        print(printVal)
    }
}

//+++++++++++++++++++++++++++

//q5 missing words
func missingWords(s: String, t: String) -> [String] {
        guard !s.isEmpty else { return [] }
        //separate strings to array by whitespaces
        let sArray = s.components(separatedBy: " ")
        let tArray = t.components(separatedBy: " ")
        var result = [String]()
        
        //for each word in sArray, if it doesn't contain by tArray, put it into result array.
        for element in sArray where !tArray.contains(element) {
            result.append(element)
        }
        
        return result
    }
    
//+++++++++++++++++++++++++++++++++
//q6 missing words

    func missingWords2(s: String, t: String) -> [String] {
        guard !s.isEmpty else { return [] }
        
        let sArray = s.components(separatedBy: " ")
        var tArray = t.components(separatedBy: " ")
        var result = [String]()
        
        for element in sArray {
            if let head = tArray.first, element == head {
                tArray.removeFirst()
            }else{
                result.append(element)
            }
        }

        return result
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++

//Q 7  frequency short
    func customSort12(arr: [Int]) -> Void {
  //store the (value, freq) to a dictionary
  let mappedItems = mapper(arr: arr)
  
  let dict = Dictionary(mappedItems, uniquingKeysWith: +)
  
  //sort dictionary, by freq first then sort by value
  var arrItem = Array(dict.keys)
  arrItem.sort{(firstItem, secondItem) in
    
    if let f = dict[firstItem], let s = dict[secondItem]{
      return (f == s ? firstItem <= secondItem : f < s)
    }else{
      return false
    }
    
  }
  
  //print out the result
  var result = [Int]()
  for item in arrItem{
    if let f = dict[item]{
      let tempArr = Array.init(repeating: item, count: f)
      result = result + tempArr
      for _ in 0..<f{
        print(item)
      }
    }
  }
}
func mapper(arr : [Int]) -> [(Int, Int)]{
  return arr.map { ($0, 1) }
}

customSort12(arr: [1,2,2,5]) //1 5 2 2
customSort12(arr: [1,2,5]) //1 2 5
customSort12(arr: [1,2,2,5, 3,3]) /* 1 5 2 2 3 3 */
customSort12(arr: [1,2,2,5, 0])
