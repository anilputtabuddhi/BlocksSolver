//
//  ZobritHash.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 05/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct ZobritHashTable{

    private let game: Game
    let table: [[[Int]]]

    init(game: Game, table: [[[Int]]]) {
        self.table = table
        self.game = game
    }

    static func createFor(game: Game) ->  ZobritHashTable {

        var table = [[[Int]]]()
        for _ in 0..<game.size.rows {
            var row = [[Int]]()
            for _ in 0..<game.size.columns {
                var values = [Int]()
                for _ in 0..<game.blockSizeTypes.count {
                    values.append(Int.random(in: 0..<Int.max))
                }
                row.append(values)
            }
            table.append(row)
        }
        return ZobritHashTable(game: game, table: table)
    }

    func getZobristHash(
        blocks: [Block],
        blockSizeTypes: [String: Int],
        gameSize: Size,
        board: Board
    ) -> (Int, Int) {
        var hash = 0
        var hashMirror = 0

        for i in 1...gameSize.rows {
            for j in 1...gameSize.columns {
                let blockIdx = board[i, j] - 1
                guard blockIdx >= 0 && blockIdx < blocks.count  else {
                    continue
                }
                let block = blocks[blockIdx]
                let sizeTypeKey = block.size.asString
                let type = blockSizeTypes[sizeTypeKey]!
                hash ^= table[i - 1][j - 1][type]
                hashMirror ^= table[i - 1][gameSize.columns - j][type]
            }
        }

      return (hash, hashMirror)
    }

    func getZobristHashUpdates(state: GameState, move: Move) -> (Int, Int) {

        let hash = getZobristHashUpdate(
            state: state,
            move: move,
            isMirror: true
        )
        let hashMirror = getZobristHashUpdate(
            state: state,
            move: move,
            isMirror: true
        )
        return (hash, hashMirror)

    }

    private func getZobristHashUpdate(
        state: GameState,
        move: Move,
        isMirror: Bool
    ) -> Int {
        var hash = isMirror ? state.hashMirror : state.hash
        let block = state.blocks[move.blockIdx]
        let gameSize = game.size
        let blockSize = block.size
        let row = block.position.row
        let type = game.blockSizeTypes[blockSize.asString]!
        let col = isMirror ?
            gameSize.columns - 1 - block.position.column
            : block.position.column
        let dx = isMirror ? -1 : 1
        let dirIdx = move.direction.rawValue
        let directions = Direction.allInCoordinates
        let dir = directions[isMirror && dirIdx % 2 == 1 ?
            (dirIdx + 2) % 4
            : dirIdx]
        let x = dir.x
        let y = dir.y

        for blockRow in 0..<blockSize.rows {
            for blockCol in 0..<blockSize.columns {
                hash ^= table[row + blockRow][col + blockCol * dx][type]
            }
        }

        for blockRow in 0..<blockSize.rows {
            for blockCol in 0..<blockSize.columns {
                hash ^= table[row + y + blockRow][col + x + blockCol * dx][type]
            }
        }

        return hash
    }
}
