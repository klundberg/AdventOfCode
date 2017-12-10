//: [Day 9](http://adventofcode.com/2017/day/9) - [Previous](@previous) - [Next](@next)

import Foundation

func removeCancelledCharacters(from input: String) -> String {
    var result = input
    while let index = result.index(of: "!") {
        result.removeSubrange(index...result.index(after: index))
    }
    return result
}

func removeGarbage(from input: String) -> (String, Int) {
    var result = input
    var removed = 0
    while let openIndex = result.index(of: "<") {
        let preRemovalCount = Int(result.count)

        let closeIndex = result.index(of: ">")!
        result.removeSubrange(openIndex...closeIndex)

        removed += preRemovalCount - result.count - 2
    }
    return (result, removed)
}

func scoreGroups(fromCleaned input: String) -> Int {
    var openedGroups = 0

    return input.reduce(into: 0, { (score, char) in
        switch char {
        case "{":
            openedGroups += 1
        case "}":
            score += openedGroups
            openedGroups -= 1
        default:
            break
        }
    })
}

func scoreGroups(_ input: String) -> Int {
    let noCancelled = removeCancelledCharacters(from: input)
    let (noGarbage, _) = removeGarbage(from: noCancelled)
    return scoreGroups(fromCleaned: noGarbage)
}

scoreGroups("{}") == 1
scoreGroups("{{{}}}") == 6
scoreGroups("{{{},{},{{}}}}") == 16

scoreGroups(input)

// part 2

func countGarbage(_ input: String) -> Int {
    let noCancelled = removeCancelledCharacters(from: input)
    let (_, removedCount) = removeGarbage(from: noCancelled)
    return removedCount
}

countGarbage("<>") == 0
countGarbage("<random characters>") == 17

countGarbage(input)
