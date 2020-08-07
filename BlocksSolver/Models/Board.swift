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

    static func createBoard(
        for gameSize: Size,
        with blocks: [Block]
    ) -> Board? {
        let board = Board.createEmpty(gameSize: gameSize)
        return board.add(blocks)
    }

    func placeBlock(_ block: Block, with blockIdx: Int) -> Board {
        var newCells = cells
        for blockRow in 1...block.size.rows {
            for blockCol in 1...block.size.columns {
                let rowIndex = block.position.row + blockRow
                let colIndex = block.position.column + blockCol
                newCells[rowIndex][colIndex] = blockIdx + 1
            }
        }
        return Board(cells: newCells)
    }

    func remove(_ block: Block) -> Board {
        var newCells = cells
        for blockRow in 1...block.size.rows {
            for blockCol in 1...block.size.columns {
                let rowIndex = block.position.row + blockRow
                let colIndex = block.position.column + blockCol
                newCells[rowIndex][colIndex] = Board.CELL_EMPTY
            }
        }
        return Board(cells: newCells)
    }

    func can(block: Block, move: Move) -> Bool {

        let dir = Direction.allInCoordinates[move.direction.rawValue]

        for blockRow in 1...block.size.rows {
            for blockColumn in 1...block.size.columns {
                let rowIndex = block.position.row + dir.y + blockRow
                let colIndex = block.position.column + dir.x + blockColumn
                let val = cells[rowIndex][colIndex]
                if (val != Board.CELL_EMPTY && val != move.blockIdx + 1) {
                    return false
                }
            }
        }
        return true
    }

    private func canPlaceBlock(_ block: Block) -> Bool {
        for row in 1...block.size.rows {
            for col in 1...block.size.columns {
                let rowIndex = block.position.row + row
                let colIndex = block.position.column + col
                if cells[rowIndex][colIndex] != Board.CELL_EMPTY {
                    return false
                }
            }
        }
        return true
    }

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

    private func add(_ blocks: [Block]) -> Board? {
        var newBoard: Board? = self
        for (idx, block) in blocks.enumerated() {
            guard let board = newBoard?.add(block, with: idx) else {
                return nil
            }
            newBoard = board
        }
        return newBoard
    }

    private func add(_ block: Block, with blockIdx: Int) -> Board? {
        guard canPlaceBlock(block) else {
            return nil
        }
        return placeBlock(block, with: blockIdx)
    }
}

extension Board {
    subscript(row: Int, column: Int) -> Int {
        return cells[row][column]
    }
}