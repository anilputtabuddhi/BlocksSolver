//
//  Game.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 05/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct Game {

    let size: Size
    let blocks: [Block]
    let masterBlockIdx: Int
    let masterGoalPosition: Position
    let blockSizeTypes: [String: Int]

    var masterBlocklabel: String {
        blocks[masterBlockIdx].label
    }

    private init(
        size: Size,
        blocks: [Block],
        masterBlockIdx: Int,
        masterGoalPosition: Position,
        blockSizeTypes: [String: Int]
    ) {
        self.size = size
        self.blocks = blocks
        self.masterBlockIdx = masterBlockIdx
        self.masterGoalPosition = masterGoalPosition
        self.blockSizeTypes = blockSizeTypes
    }

    static func createGame(
        blocks: [Block],
        size: Size,
        masterGoalPosition: Position,
        masterBlockIdx: Int
    ) -> Game? {

        let blockSizeTypes = Game.blockSizeTypesFrom(blocks)

        return Game(
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
        blocks: klotskiBlocks,
        size: Size(5, 4),
        masterGoalPosition: Position(3, 1),
        masterBlockIdx: 0
    )!
}










