//
//  BlocksMoveSolverTests.swift
//  BlocksSolverTests
//
//  Created by Anil Puttabuddhi on 09/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import XCTest
@testable import BlocksSolver

class BlocksMoveSolverTests: XCTestCase {
    
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
}
