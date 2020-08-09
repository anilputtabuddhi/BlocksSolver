//
//  Board.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 05/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct Board {

    static let CELL_EMPTY = 0
    static let CELL_BORDER = -1

    private let cells: [[Int]]

}

// Mark: - Public Interface

extension Board {

    static func createBoard(
        for gameSize: Size,
        with blocks: [Block],
        in positions: [Position]
    ) -> Board? {
        let board = Board.createEmpty(gameSize: gameSize)
        return board.add(blocks, in: positions)
    }

    func move(_ block: Block,
              from position: Position,
              to newPosition: Position
    ) -> Board {
        return self.remove(block, in: position).place(block, in: newPosition)
    }

    func canBlock(_ move: Move, from position: Position) -> Bool {

        let dir = Direction.allInCoordinates[move.direction.rawValue]
        for blockRow in 1...move.block.size.rows {
            for blockColumn in 1...move.block.size.columns {
                let rowIndex = position.row + dir.y + blockRow
                let colIndex = position.column + dir.x + blockColumn
                let val = cells[rowIndex][colIndex]
                if (val != Board.CELL_EMPTY && val != move.block.id + 1) {
                    return false
                }
            }
        }
        return true
    }

    subscript(row: Int, column: Int) -> Int {
        return cells[row][column]
    }
}

// Mark: - Private methods

extension Board {

    private static func createEmpty(
        gameSize: Size
    ) -> Board {
        let boardSize = Size(
            gameSize.rows + 2,
            gameSize.columns + 2
        )
        var cells: [[Int]] = Array(
            repeating: Array(repeating: CELL_EMPTY, count: boardSize.columns),
            count: boardSize.rows
        )

        for i in 0..<boardSize.rows {
            cells[i][0] = CELL_BORDER
            cells[i][boardSize.columns - 1] = CELL_BORDER
        }

        for i in 1..<(boardSize.columns - 1) {
            cells[0][i] = CELL_BORDER
            cells[boardSize.rows - 1][i] = CELL_BORDER
        }
        return Board(cells: cells)
    }

    private func add(_ blocks: [Block], in positions: [Position]) -> Board? {
        var newBoard: Board? = self
        for (block, position) in zip(blocks, positions) {
            guard let board = newBoard?.add(block, in: position) else {
                return nil
            }
            newBoard = board
        }
        return newBoard
    }

    private func add(_ block: Block, in position: Position) -> Board? {
        guard canPlaceBlock(block, in: position) else {
            return nil
        }
        return place(block, in: position)
    }

    private func place(_ block: Block, in position: Position) -> Board {
        return set(value: block.id + 1, for: block, in: position)
    }

    private func remove(_ block: Block, in position: Position) -> Board {
        return set(value: Board.CELL_EMPTY, for: block, in: position)
    }

    private func set(value: Int, for block: Block, in position: Position) -> Board {
        var newCells = cells
        for blockRow in 1...block.size.rows {
            for blockCol in 1...block.size.columns {
                let rowIndex = position.row + blockRow
                let colIndex = position.column + blockCol
                newCells[rowIndex][colIndex] = value
            }
        }
        return Board(cells: newCells)
    }

    private func canPlaceBlock(_ block: Block, in position: Position) -> Bool {
        for row in 1...block.size.rows {
            for col in 1...block.size.columns {
                let rowIndex = position.row + row
                let colIndex = position.column + col
                if cells[rowIndex][colIndex] != Board.CELL_EMPTY {
                    return false
                }
            }
        }
        return true
    }
}
