//
//  BlocksSolverTests.swift
//  BlocksSolverTests
//
//  Created by Anil Puttabuddhi on 05/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import XCTest
@testable import BlocksSolver

class BlocksSolverTests: XCTestCase {

    let blocks = [
        Block("B", size: Size(2, 2), position: Position(0, 1)), //B
        Block("A", size: Size(2, 1), position: Position(0, 0)), //A
        Block("C", size: Size(2, 1), position: Position(0, 3)), //C
        Block("D", size: Size(2, 1), position: Position(2, 0)), //D
        Block("F", size: Size(2, 1), position: Position(2, 3)), //F
        Block("E", size: Size(1, 2), position: Position(2, 1)), //E
        Block("I", size: Size(1, 1), position: Position(4, 0)), //I
        Block("G", size: Size(1, 1), position: Position(3, 1)), //G
        Block("H", size: Size(1, 1), position: Position(3, 2)), //H
        Block("J", size: Size(1, 1), position: Position(4, 3))  //J
    ]

    let blockSizeTypes = [
        "1_1": 0,
        "1_2": 1,
        "2_1": 2,
        "2_2": 3,
    ]

    func testZobritHashInitialise() {
        let game = Game.createGame(
            blocks: blocks,
            size: Size(5, 4),
            masterGoalPosition: Position(3, 1),
            masterBlockIdx: 0
        )

        let zobHashTable = ZobritHashTable.createFor(game: game!)

        XCTAssertTrue(zobHashTable.table.count == 5)
        zobHashTable.table.forEach { (row) in
            XCTAssertTrue(row.count == 4)
            row.forEach{ col in
                XCTAssertTrue(row.count == 4)
            }
        }
    }

    func testStateCreation() {

        let game = Game.createGame(
            blocks: blocks,
            size: Size(5, 4),
            masterGoalPosition: Position(3, 1),
            masterBlockIdx: 0
        )
        let state = GameState.createInitialStateWith(game: game!)
        XCTAssertNotNil(state)
    }

    func testGameCreation() {

        let game = Game.createGame(
            blocks: blocks,
            size: Size(5, 4),
            masterGoalPosition: Position(3, 1),
            masterBlockIdx: 0
        )
        XCTAssertNotNil(game)
    }

    func testSolver() {
        let solver = BlocksMoveSolver(game: Game.klotski)!
        let result = solver.solve()
        if case .success(let moves) = result {
            XCTAssertEqual(moves.count, 106)
        } else {
            XCTFail("Expected success")
        }
    }

    func testHashSameWhenBoardConfigSymmetrical() {

        let game = Game.createGame(
            blocks: blocks,
            size: Size(5, 4),
            masterGoalPosition: Position(3, 1),
            masterBlockIdx: 0
        )!

        let state = GameState.createInitialStateWith(game: game)!

        XCTAssertEqual(state.hash, state.hashMirror)
    }

    func testHashDifferentWhenBoardConfigASymmetrically() {
        var localBlocks = blocks
        localBlocks[8] = Block("H", size: Size(1, 1), position: Position(4, 2))
        localBlocks[7] = Block("G", size: Size(1, 1), position: Position(3, 2)) 
        localBlocks[8] = Block("I", size: Size(1, 1), position: Position(4, 1))

        let game = Game.createGame(
            blocks: localBlocks,
            size: Size(5, 4),
            masterGoalPosition: Position(3, 1),
            masterBlockIdx: 0
        )!

        let state = GameState.createInitialStateWith(game: game)!

        XCTAssertNotEqual(state.hash, state.hashMirror)
    }

}
