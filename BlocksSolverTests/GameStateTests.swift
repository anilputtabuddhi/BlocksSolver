//
//  GameStateTests.swift
//  BlocksSolverTests
//
//  Created by Anil Puttabuddhi on 09/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import XCTest
@testable import BlocksSolver

class GameStateTests: XCTestCase {

    var state: GameState!

    override func setUp() {
        let game = Game.klotski
        let board = Board.createBoard(
            for: game.size,
            with: game.blocks,
            in: game.initialBlockPositions
        )!
        state = GameState(
            game: game,
            hashProvider: { (state, move) -> (Int, Int) in
                return (1, 1)
            },
            board: board,
            move: nil,
            positions: Game.klotskiBlockPositions,
            hash: 2,
            hashMirror: 2
        )
    }

    func testStateCreation() {
        let states = BlocksMoveSolver(game: Game.klotski)!.states
        XCTAssertNotNil(states[0])
    }

    func testHashSameWhenBoardConfigSymmetrically() {
        let states = BlocksMoveSolver(game: Game.klotski)!.states
        XCTAssertEqual(states[0].hash, states[0].hashMirror)
    }

    func testIsGoal() {
        XCTAssertFalse(state.isGoal)
    }

    func testEstimatedCost() {
        XCTAssertEqual(state.estimatedCostToDestination, 3)
    }

    func testConnectedNode() {
        XCTAssertEqual(state.connectedNodes.count, 4)
    }

    func testCost() {
        let anotherNode = state.connectedNodes.first!
        XCTAssertEqual(state.cost(to: anotherNode), 1)
    }
    
}
