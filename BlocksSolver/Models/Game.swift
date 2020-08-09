//
//  Game.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 05/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct Game {

    let desc: String
    let size: Size
    let blocks: [Block]
    let initialBlockPositions: [Position]
    let masterBlockIdx: Int
    let masterGoalPosition: Position
    let blockSizeTypes: [String: Int]

    var masterBlocklabel: String {
        blocks[masterBlockIdx].label
    }

    static func createGame(
        desc: String,
        blocks: [Block],
        initialBlockPositions: [Position],
        size: Size,
        masterGoalPosition: Position,
        masterBlockIdx: Int
    ) -> Game? {

        let blockSizeTypes = Game.blockSizeTypesFrom(blocks)

        return Game(
            desc: desc,
            size: size,
            blocks: blocks,
            initialBlockPositions: initialBlockPositions,
            masterBlockIdx: masterBlockIdx,
            masterGoalPosition: masterGoalPosition,
            blockSizeTypes: blockSizeTypes
        )
    }

    private static func blockSizeTypesFrom(_ blocks: [Block]) -> [String: Int] {
        let setOfUniqueSizeDescriptions = Set(blocks.map(\.size.asString))

        var blockSizeTypes: [String: Int] = [:]

        for (idx, sizeDesc) in setOfUniqueSizeDescriptions.enumerated() {
            blockSizeTypes[sizeDesc] = idx
        }

        return blockSizeTypes
    }
}

extension Game {
    static let all: [Game] = [.klotski, .unBlockMe]
}

extension Game {
     static let klotskiBlocks = [
        Block("A", id: 0, size: Size(2, 1)),
        Block("B", id: 1, size: Size(2, 2)),
        Block("C", id: 2, size: Size(2, 1)),
        Block("D", id: 3, size: Size(2, 1)),
        Block("F", id: 4, size: Size(2, 1)),
        Block("E", id: 5, size: Size(1, 2)),
        Block("I", id: 6, size: Size(1, 1)),
        Block("G", id: 7, size: Size(1, 1)),
        Block("H", id: 8, size: Size(1, 1)),
        Block("J", id: 9, size: Size(1, 1)),
    ]

    static let klotskiBlockPositions = [
        Position(0, 0),
        Position(0, 1),
        Position(0, 3),
        Position(2, 0),
        Position(2, 3),
        Position(2, 1),
        Position(4, 0),
        Position(3, 1),
        Position(3, 2),
        Position(4, 3),
    ]

    static var klotski = Game.createGame(
        desc: "Klotski",
        blocks: klotskiBlocks,
        initialBlockPositions: klotskiBlockPositions,
        size: Size(5, 4),
        masterGoalPosition: Position(3, 1),
        masterBlockIdx: 1
    )!
}

extension Game {
    static let upDown: [Direction] = [.up, .down]
    static let lefRight: [Direction] = [.left, .right]

     static let unBlockMeBlocks = [
        Block("A", id: 0, size: Size(1, 2), allowedDirections: Game.lefRight),
        Block("B", id: 1, size: Size(1, 2), allowedDirections: Game.lefRight),
        Block("C", id: 2, size: Size(1, 2), allowedDirections: Game.lefRight),
        Block("D", id: 3, size: Size(1, 2), allowedDirections: Game.lefRight),
        Block("E", id: 4, size: Size(1, 2), allowedDirections: Game.lefRight),
        Block("F", id: 5, size: Size(1, 2), allowedDirections: Game.lefRight),
        Block("G", id: 6, size: Size(3, 1), allowedDirections: Game.upDown),
        Block("H", id: 7, size: Size(2, 1), allowedDirections: Game.upDown),
        Block("I", id: 8, size: Size(2, 1), allowedDirections: Game.upDown),
        Block("J", id: 9, size: Size(2, 1), allowedDirections: Game.upDown),
        Block("K", id: 10, size: Size(2, 1), allowedDirections: Game.upDown),
        Block("L", id: 11, size: Size(3, 1), allowedDirections: Game.upDown),
        Block("M", id: 12, size: Size(3, 1), allowedDirections: Game.upDown),
    ]

    static let unblockMeBlockPositions = [
        Position(0, 1),
        Position(2, 2),
        Position(3, 0),
        Position(4, 4),
        Position(5, 1),
        Position(5, 3),
        Position(0, 0),
        Position(1, 1),
        Position(3, 2),
        Position(0, 3),
        Position(3, 3),
        Position(1, 4),
        Position(0, 5),
    ]
    static var unBlockMe = Game.createGame(
        desc: "UnblockMe",
        blocks: unBlockMeBlocks,
        initialBlockPositions: unblockMeBlockPositions,
        size: Size(6, 6),
        masterGoalPosition: Position(2, 4),
        masterBlockIdx: 1
    )!
}










