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
    let masterBlockIdx: Int
    let masterGoalPosition: Position
    let blockSizeTypes: [String: Int]

    var masterBlocklabel: String {
        blocks[masterBlockIdx].label
    }

    private init(
        desc: String,
        size: Size,
        blocks: [Block],
        masterBlockIdx: Int,
        masterGoalPosition: Position,
        blockSizeTypes: [String: Int]
    ) {
        self.desc = desc
        self.size = size
        self.blocks = blocks
        self.masterBlockIdx = masterBlockIdx
        self.masterGoalPosition = masterGoalPosition
        self.blockSizeTypes = blockSizeTypes
    }

    static func createGame(
        desc: String,
        blocks: [Block],
        size: Size,
        masterGoalPosition: Position,
        masterBlockIdx: Int
    ) -> Game? {

        let blockSizeTypes = Game.blockSizeTypesFrom(blocks)

        return Game(
            desc: desc,
            size: size,
            blocks: blocks,
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
     static let klotskiBlocks = [
        Block("B", size: Size(2, 2), position: Position(0, 1)), // B = 0
        Block("A", size: Size(2, 1), position: Position(0, 0)), // A = 1
        Block("C", size: Size(2, 1), position: Position(0, 3)), // C = 2
        Block("D", size: Size(2, 1), position: Position(2, 0)), // D = 3
        Block("F", size: Size(2, 1), position: Position(2, 3)), // F = 4
        Block("E", size: Size(1, 2), position: Position(2, 1)), // E = 5
        Block("I", size: Size(1, 1), position: Position(4, 0)), // I = 6
        Block("G", size: Size(1, 1), position: Position(3, 1)), // G = 7
        Block("H", size: Size(1, 1), position: Position(3, 2)), // H = 8
        Block("J", size: Size(1, 1), position: Position(4, 3)), // J = 9
    ]

    static var klotski = Game.createGame(
        desc: "Game of Klotski",
        blocks: klotskiBlocks,
        size: Size(5, 4),
        masterGoalPosition: Position(3, 1),
        masterBlockIdx: 0
    )!
}

extension Game {
    static let upDown: [Direction] = [.up, .down]
    static let lefRight: [Direction] = [.left, .right]

     static let unBlockMeBlocks = [
        Block("A", size: Size(1, 2), position: Position(0, 1), allowedDirections: Game.lefRight),
        Block("B", size: Size(1, 2), position: Position(2, 2), allowedDirections: Game.lefRight),
        Block("C", size: Size(1, 2), position: Position(3, 0), allowedDirections: Game.lefRight),
        Block("D", size: Size(1, 2), position: Position(4, 4), allowedDirections: Game.lefRight),
        Block("E", size: Size(1, 2), position: Position(5, 1), allowedDirections: Game.lefRight),
        Block("F", size: Size(1, 2), position: Position(5, 3), allowedDirections: Game.lefRight),
        Block("G", size: Size(3, 1), position: Position(0, 0), allowedDirections: Game.upDown),
        Block("H", size: Size(2, 1), position: Position(1, 1), allowedDirections: Game.upDown),
        Block("I", size: Size(2, 1), position: Position(3, 2), allowedDirections: Game.upDown),
        Block("J", size: Size(2, 1), position: Position(0, 3), allowedDirections: Game.upDown),
        Block("K", size: Size(2, 1), position: Position(3, 3), allowedDirections: Game.upDown),
        Block("L", size: Size(3, 1), position: Position(1, 4), allowedDirections: Game.upDown),
        Block("M", size: Size(3, 1), position: Position(0, 5), allowedDirections: Game.upDown),
    ]

    static var unBlockMe = Game.createGame(
        desc: "UnblockMe Level 701",
        blocks: unBlockMeBlocks,
        size: Size(6, 6),
        masterGoalPosition: Position(2, 4),
        masterBlockIdx: 1
    )!
}










