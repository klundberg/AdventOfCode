//: [Day 7](http://adventofcode.com/2017/day/7) - [Previous](@previous) - [Next](@next)
import Foundation

struct Node {
    var name: String
    var weight: Int
    var childrenNames: [String]

    func childrenNodes(_ nodes: [String: Node]) -> [Node] {
        return childrenNames.map { nodes[$0]! }
    }

    func childrenWeights(_ nodes: [String: Node]) -> [String: Int] {
        let weights = childrenNames.map({ nodes[$0]!.totalWeight(nodes) })
        return Dictionary(uniqueKeysWithValues: zip(childrenNames, weights))
    }

    func totalWeight(_ nodes: [String: Node]) -> Int {
        return childrenWeights(nodes).values.reduce(weight, +)
    }

    func unbalancedNode(_ nodes: [String: Node]) -> Node? {
        let weights = childrenWeights(nodes)
        guard weights.count > 1 else { return nil }

        let firstWeight = weights.first!
        var sawFirst = false
        var differentNode: (key: String, value: Int)?

        for (key, value) in weights.dropFirst() {
            if value == firstWeight.value {
                sawFirst = true
            }
            if value != firstWeight.value {
                differentNode = (key, value)
            }
        }

        if differentNode == nil {
            return nil
        }

        if sawFirst {
            return nodes[differentNode!.key]
        } else {
            return nodes[firstWeight.key]
        }
    }
}

func parseNodeString(_ nodeStr: Substring) -> Node {
    let parts = nodeStr.split(separator: " ")
    let name = String(parts.first!)
    let weight = Int(parts[1].trimmingCharacters(in: CharacterSet.decimalDigits.inverted))!
    let rest = parts.dropFirst(3)
    let childNames: [String] = rest.map({ String($0.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)) })

    return Node(name: name, weight: weight, childrenNames: childNames)
}

func parseUnstructured(_ input: String) -> [String: Node] {
    let nodeStrs = input.split(separator: "\n")
    let nodes = nodeStrs.map(parseNodeString)
    return Dictionary.init(uniqueKeysWithValues: zip(nodes.map({ $0.name }), nodes))
}

let exampleNodes = parseUnstructured(example)
let nodes = parseUnstructured(input)

func part1_rootNodeName(_ nodes: [String: Node]) -> String {
    var seenAsChildren: Set<String> = []

    for node in nodes.values {
        for child in node.childrenNames {
            seenAsChildren.insert(child)
        }
    }

    return nodes.values.lazy.filter { (node) -> Bool in
        return !seenAsChildren.contains(node.name)
        }.first!.name
}

part1_rootNodeName(nodes)

func part2_targetWeightForUnbalancedNode(_ nodes: [String: Node]) -> Int {

    let node = nodes.values.lazy.filter({ node in
        return node.unbalancedNode(nodes) != nil
    }).first!

    var childWeights = node.childrenWeights(nodes)
    let unbalanced = node.unbalancedNode(nodes)!
    childWeights.removeValue(forKey: unbalanced.name)

    let targetTotalWeight = childWeights.first!.value
    let totalWeight = unbalanced.totalWeight(nodes)

    let weight = unbalanced.weight

    return weight - (totalWeight - targetTotalWeight)
}

part2_targetWeightForUnbalancedNode(nodes)

