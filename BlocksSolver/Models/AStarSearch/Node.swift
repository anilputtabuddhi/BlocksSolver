//
//  Node.swift
//  BlocksSolver
//
//  Created by Damiaan Dufaux on 21/08/16.
//  Modified by Anil Puttabuddhi to suit needs
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

protocol GraphNode {
    var connectedNodes: [Self] { get }
    var estimatedCostToDestination: Int { get }
    func cost(to node: Self) -> Int
    var isGoal: Bool { get }
    var hash: Int { get }
    var hashMirror: Int { get }
}

class Step<Node: GraphNode> {
    var node: Node
    var previous: Step?
    var stepCost: Int
    var goalCost: Int

    init(from start: Node, to destination: Node) {
        node = destination
        stepCost = start.cost(to: destination)
        goalCost = destination.estimatedCostToDestination
    }

    init(destination: Node, previous: Step) {
        (node, self.previous) = (destination, previous)
        stepCost = previous.stepCost + previous.node.cost(to: destination)
        goalCost = destination.estimatedCostToDestination
    }

    var cost: Int {
        return stepCost + goalCost
    }

}

extension Step: Hashable, Equatable, Comparable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(node.hash)
    }

    static func ==(lhs: Step, rhs: Step) -> Bool {
        return lhs.node.hash == rhs.node.hash
    }

    public static func <(lhs: Step, rhs: Step) -> Bool {
        return lhs.cost < rhs.cost
    }

    public static func <=(lhs: Step, rhs: Step) -> Bool {
        return lhs.cost <= rhs.cost
    }

    public static func >=(lhs: Step, rhs: Step) -> Bool {
        return lhs.cost >= rhs.cost
    }

    public static func >(lhs: Step, rhs: Step) -> Bool {
        return lhs.cost > rhs.cost
    }

}

extension GraphNode {

    public func findPathToGoal() -> [Self] {

        var possibleSteps = [Step<Self>]()
        var eliminatedNodes: [Int: Bool] = [:]
        var openList: [Int: Step<Self>] = [:]

        for connectedNode in connectedNodes {
            let step = Step(from: self, to: connectedNode)
            possibleSteps.sortedInsert(newElement: step)
            openList[step.node.hash] = step
        }

        var path = [Self]()
        while !possibleSteps.isEmpty {
            let currentStep = possibleSteps.removeFirst()
            openList[currentStep.node.hash] = nil

            if currentStep.node.isGoal {
                var cursor = currentStep
                path.insert(currentStep.node, at: 0)
                while let previous = cursor.previous {
                    cursor = previous
                    path.insert(previous.node, at: 0)
                }
                break
            }

            eliminatedNodes[currentStep.node.hash] = true
            eliminatedNodes[currentStep.node.hashMirror] = true

            let nextNodes = currentStep.node.connectedNodes.filter { node in
                eliminatedNodes[node.hash] != true &&
                eliminatedNodes[node.hashMirror] != true
            }

            for node in nextNodes {
                let nextStep = Step(destination: node, previous: currentStep)
                if let existingStepForNode = openList[node.hash],
                    existingStepForNode.stepCost <= nextStep.stepCost {
                    continue
                }
                let index = possibleSteps.binarySearch(element: nextStep)
                if index < possibleSteps.count && possibleSteps[index] == nextStep {
                    if nextStep.stepCost < possibleSteps[index].stepCost {
                        possibleSteps[index].previous = currentStep
                    }
                } else {
                    possibleSteps.sortedInsert(newElement: nextStep)
                    openList[nextStep.node.hash] = nextStep
                }

            }

        }

        if path.count > 0 || self.isGoal {
            path.insert(self, at: 0)
        }

        return path
    }
}
