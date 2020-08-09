//
//  GameTests.swift
//  BlocksSolverTests
//
//  Created by Anil Puttabuddhi on 09/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import XCTest
@testable import BlocksSolver

class GameTests: XCTestCase {

    func testGameCreation() {
        let game = Game.klotski
        XCTAssertNotNil(game)
        XCTAssert(game.blockSizeTypes.keys.count == 4)
    }

    func testHashDifferentWhenBoardConfigAsymmetrically() {
        let blocks = [
            Block("B", id: 0, size: Size(2, 2)),
            Block("A", id: 1, size: Size(2, 1)),
        ]

        let positions = [
            Position(0, 1),
            Position(0, 0)
        ]

        let game = Game.createGame(
            desc: "yyy",
            blocks: blocks,
            initialBlockPositions: positions,
            size: Size(5, 4),
            masterGoalPosition: Position(3, 1),
            masterBlockIdx: 0
        )!

        let states = BlocksMoveSolver(game: game)!.states

        XCTAssertNotEqual(states[0].hash, states[0].hashMirror)
    }
}




