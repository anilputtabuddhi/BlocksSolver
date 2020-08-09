//
//  ZobritHashTests.swift
//  BlocksSolverTests
//
//  Created by Anil Puttabuddhi on 09/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import XCTest
@testable import BlocksSolver

class ZobritHashTests: XCTestCase {

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
}
