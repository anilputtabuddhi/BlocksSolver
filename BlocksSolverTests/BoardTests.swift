//
//  BoardTests.swift
//  BlocksSolverTests
//
//  Created by Anil Puttabuddhi on 09/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import XCTest
@testable import BlocksSolver

class BoardTests: XCTestCase {

    var board: Board!

    override func setUp() {
        let game = Game.klotski
        board = Board.createBoard(for: game.size,
                                      with: game.blocks,
                                      in: game.initialBlockPositions)
    }

    func testBoardCreation() {
        XCTAssertNotNil(board)
    }

    func testBoardCanMoveSuccess() {
        //Try to move block B as first move
        let move = Move(Game.klotski.blocks[1], .down)
        let position = Game.klotskiBlockPositions[1]
        let canMove = board.canBlock(move, from: position)
        XCTAssertFalse(canMove)
    }

    func testBoardCanMoveFailure() {
        //Try to move block I right as first move - should succeed
        let move = Move(Game.klotski.blocks[6], .right)
        let position = Game.klotskiBlockPositions[6]
        let canMove = board.canBlock(move, from: position)
        XCTAssertTrue(canMove)
    }

    func testBoardMove() {
        //Try to move block I right as first move - should succeed
        let block = Game.klotskiBlocks[6]
        let move = Move(Game.klotski.blocks[6], .right)

        //Move block I right twice. So it cant move anymore to the right
        let newBoard =
            board.move(block, from: Position(4, 0), to: Position(4, 1))
            .move(block, from: Position(4, 1), to: Position(4, 2))

        let canMove = newBoard.canBlock(move, from: Position(4, 2))
        XCTAssertFalse(canMove)
    }

}
