//: [Day 6](http://adventofcode.com/2017/day/6) - [Previous](@previous) - [Next](@next)

var banks = [11, 11, 13, 7, 0, 15, 5, 5, 4, 4, 1, 1, 7, 1, 15, 11]

func cyclesBeforeRepeat(_ banks: [Int]) -> ([[Int]], Int) {
    var banks = banks
    var cycles: [[Int]] = []

    repeat {
        cycles.append(banks)
        let max = banks.max()!
        let index = banks.index(of: max)!
        banks[index] = 0

        for i in (0..<banks.count) {
            banks[i] += max / banks.count
        }

        let remainder = max % banks.count
        for i in (index+1)..<(index+remainder+1) {
            banks[i % banks.count] += 1
        }

    } while !cycles.contains(where: { $0 == banks })


    return (cycles, cycles.index(where: { $0 == banks })!)
}

var (cycles, index) = cyclesBeforeRepeat([0,2,7,0])
cycles.count
cycles.count - index // part 2

(cycles, index) = cyclesBeforeRepeat(banks)
cycles.count
cycles.count - index // part 2
