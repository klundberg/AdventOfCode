//: [Day 10](http://adventofcode.com/2017/day/10) - [Previous](@previous) - [Next](@next)

import Foundation

extension Array {
    func rotated(to index: Index) -> [Element] {
        guard index != 0 else { return self }
        let modIndex = index % count
        let adjustedIndex = modIndex > 0 ? modIndex : (count + modIndex)

        let firstRange = adjustedIndex...
        let secondRange = ..<adjustedIndex
        return Array(self[firstRange] + self[secondRange])
    }

    mutating func rotate(to index: Index) {
        self = rotated(to: index)
    }
}

func knotHashRound(_ input: [UInt8], rounds: Int) -> [UInt8] {
    var list = Array<UInt8>(0...255)
    var position = 0
    var skipSize = 0

    for _ in 0..<rounds {
        // reverse it so we can repeatedly call popLast until its empty
        var lengths = Array(input.reversed()).map({ Int($0) })
        while let length = lengths.popLast() {
            list.rotate(to: position)
            list[0..<length] = ArraySlice(list[0..<length].reversed())
            list.rotate(to: -position)

            position += (length + skipSize) % list.count
            skipSize += 1
        }
    }
    return list
}

let list = knotHashRound([183,0,31,146,254,240,223,150,2,206,161,1,255,232,199,88], rounds: 1)
Int(list[0]) * Int(list[1])

// part 2

func densify(_ input: [UInt8]) -> [UInt8] {
    var sparseHash = input
    var denseHash: [UInt8] = []
    while sparseHash.count > 0 {
        let chunk = sparseHash[0..<16]
        sparseHash.removeSubrange(0..<16)

        let xored = chunk.dropFirst().reduce(into: chunk.first!, { (result, value) in
            result ^= value
        })
        denseHash.append(xored)
    }
    return denseHash
}

func toHex(_ input: [UInt8]) -> String {
    return input.map({
        if $0 < 16 {
            return "0" + String($0, radix: 16, uppercase: false)
        } else {
            return String($0, radix: 16, uppercase: false)
        }
    }).joined(separator: "")
}

func knotHash(_ input: String) -> String {
    let inputAscii = Array(input.trimmingCharacters(in: .whitespaces).utf8) + [17, 31, 73, 47, 23]
    let sparseHash = knotHashRound(inputAscii, rounds: 64)
    let denseHash = densify(sparseHash)
    return toHex(denseHash)
}

// tests
knotHash("") == "a2582a3a0e66e6e86e3812dcb672a272"
knotHash("AoC 2017") == "33efeb34ea91902bb2f59c9920caa6cd"
knotHash("1,2,3") == "3efbe78a8d82f29979031a4aa0b16a9d"
knotHash("1,2,4") == "63960835bcdc130f0b66d7ff4f6a5a8e"

// calculate answer
knotHash("183,0,31,146,254,240,223,150,2,206,161,1,255,232,199,88")
