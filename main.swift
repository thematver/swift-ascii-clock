import Foundation

extension String: Error {}

var numbers: [String] = [ "    0000000           11111          22222222        333333333                4444       5555555555          6666666    7777777777777       88888888         9999999    ",
                          "   0000000000       1111111         22222222222      33333333333             44444      55555555555        666666666    7777777777777     88888888888      99999999999  ",
                          "  0000    0000      111 111         22      2222     33      333            444444     555                66666                  7777    8888     8888    9999     9999 ",
                          " 000        000         111                  222             3333          444 444     555               666                     777     888       888    999       999 ",
                          " 000        000         111                  222             333          444  444     55               666                     777      8888     8888   9999       999 ",
                          " 000        000         111                 2222       33333333          444   444     555555555        66666666666            777       88888  88888    9999       999",
                          " 000        000         111                 222        3333333          444    444     55555555555     66666666666666         7777          8888888       9999     9999 ",
                          " 000        000         111               2222            333333       444     444             5555    6666       666        7777         88888888888      999999999999 ",
                          " 000        000         111              2222                3333     44444444444444            555    666        6666      7777         8888     8888      9999999 999 ",
                          " 000        000         111            22222                  333    444444444444444            555    666        6666      777         8888       8888            9999 ",
                          " 0000      0000         111           2222                    333              444              555     666       666      7777         8888       8888           9999  ",
                          "  0000    0000          111         2222             33      3333              444     5      5555      6666     6666     7777           8888     8888          99999   ",
                          "   0000000000           111        2222222222222    333333333333               444    55555555555        66666666666     7777             88888888888      99999999     ",
                          "     000000             111        2222222222222     333333333                 444     55555555            6666666       777                8888888        999999       "]

var dots: [String] = [" ## ",
                      " ## "]



func printNumber(number: Int) throws -> [String]  {
    
    if (number < 0 || number > 9) {
        throw "Number should be less than 0 and more than 9"
    }
    
    let startPosition = number * 17
    let endPosition = startPosition + 17
    var array = [String](repeating: "", count: 14)
    var position: Int = 0
    
    for numberPart in numbers {
        let startIndex = numberPart.index(numberPart.startIndex, offsetBy: startPosition)
        let endIndex = numberPart.index(numberPart.startIndex, offsetBy: number == 9 ? endPosition - 3 : endPosition)
        let range = startIndex..<endIndex
        array[position] += numberPart[range]
        position += 1
    }
    
    return array;
}


func separate(number: Int) -> [Int] {
    if (number < 10) {
        return [0, number]
    }
    var numbers =  [Int]()
    var num = number
    repeat {
        numbers.append(num % 10)
        num /= 10
    }    while (num != 0)
    return numbers.reversed()
}

func getAsciiDots() -> [String] {
    var finalArray = [String](repeating: "      ", count: 14)
    
   
        finalArray[6] = " ##   "
        finalArray[8] = " ##   "
    
    
    return finalArray
}

func print(time: Date) {
    let hours = Calendar.current.component(.hour, from: Date())
    let minutes = Calendar.current.component(.minute, from: Date())
    var array = [String](repeating: "", count: 16)
    var counter = 0
    

    for number in separate(number: hours) {
      
       let asciiNumber = try! printNumber(number: number)
        for asciiNumberPart in asciiNumber {
            array[counter].append(contentsOf: asciiNumberPart)
            counter+=1
        }
        counter = 0
    }
    

    for line in getAsciiDots() {
        array[counter].append(line)
        counter += 1
    }
    
    counter = 0
    
    
    
    for number in separate(number: minutes) {
        let asciiNumber = try! printNumber(number: number)
        for asciiNumberPart in asciiNumber {
            array[counter].append(contentsOf: asciiNumberPart)
            counter+=1
        }
        counter = 0
    }
    array.insert(contentsOf: [String](repeating: " ", count: 4), at: 0)
    for str in array {
        print(str)
    }
 
}

print(time: Date.now)
