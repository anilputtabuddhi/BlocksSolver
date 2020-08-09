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

    func testZobritHashInitialise() {
        let zobHashTable = ZobritHashTable.createFor(game: Game.klotski)

        XCTAssertTrue(zobHashTable.table.count == 5)
        zobHashTable.table.forEach { (row) in
            XCTAssertTrue(row.count == 4)
            row.forEach{ col in
                XCTAssertTrue(row.count == 4)
            }
        }
    }

    func testStateCreation() {
        let states = BlocksMoveSolver(game: Game.klotski)!.states
        XCTAssertNotNil(states[0])
    }

    func testGameCreation() {
        let game = Game.klotski
        XCTAssertNotNil(game)
    }

    func testSolverForKlotski() {
        let solver = BlocksMoveSolver(game: Game.klotski)!
        let result = solver.solve()
        if result {
            XCTAssertEqual(solver.states.count, 106)
        } else {
            XCTFail("Expected success")
        }
    }

    func testSolverForUnblockMe() {
        let solver = BlocksMoveSolver(game: Game.unBlockMe)!
        let result = solver.solve()
        if result {
            XCTAssertEqual(solver.states.count, 45)
        } else {
            XCTFail("Expected success")
        }
    }

    func testHashSameWhenBoardConfigSymmetrically() {
        let states = BlocksMoveSolver(game: Game.klotski)!.states
        XCTAssertEqual(states[0].hash, states[0].hashMirror)
    }

    func testHashDifferentWhenBoardConfigAsymmetrically() {
        let blocks = [
            Block("B", id: 0, size: Size(2, 2), position: Position(0, 1)),
            Block("A", id: 1, size: Size(2, 1), position: Position(0, 0)),
        ]

        let game = Game.createGame(
            desc: "yyy",
            blocks: blocks,
            size: Size(5, 4),
            masterGoalPosition: Position(3, 1),
            masterBlockIdx: 0
        )!

        let states = BlocksMoveSolver(game: game)!.states

        XCTAssertNotEqual(states[0].hash, states[0].hashMirror)
    }

}
