//
//  State.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 05/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

final class GameState {

    private let game: Game
    private let zhashTable: ZobritHashTable
    private let board: Board

    let move: Move?
    let blocks: [Block]
    let hash: Int
    let hashMirror: Int

    init(
        game: Game,
        zhashTable: ZobritHashTable,
        board: Board,
        move: Move?,
        blocks: [Block],
        hash: Int,
        hashMirror: Int
    ){
        self.game = game
        self.zhashTable = zhashTable
        self.board = board
        self.move = move
        self.blocks = blocks
        self.hash = hash
        self.hashMirror = hashMirror
    }

    static func createInitialStateWith(game: Game) -> GameState? {

        let zhashTable = ZobritHashTable.createFor(game: game)

        guard let board = Board.createBoard(
            for: game.size,
            with: game.blocks
            ) else {
                return nil
        }

        let (hash, hashMirror) = zhashTable.getZobristHash(
            blocks: game.blocks,
            blockSizeTypes: game.blockSizeTypes,
            gameSize: game.size,
            board: board
        )

        return GameState(
            game: game,
            zhashTable: zhashTable,
            board: board,
            move: nil,
            blocks: game.blocks,
            hash: hash,
            hashMirror: hashMirror
        )
    }

    private func newStateWithPossibleMove(_ move: Move) -> GameState {
        let block = blocks[move.blockIdx]

        let (newHash, newHashMirror) =
            zhashTable.getZobristHashUpdates(state: self, move: move)

        var newBoard = board
        newBoard = newBoard.remove(block)

        let dir = Direction.allInCoordinates[move.direction.rawValue]
        let newBlock = block.withNewPosition(
            Position(
                block.position.row + dir.y,
                block.position.column + dir.x
            )
        )

        newBoard = newBoard.placeBlock(newBlock, with: move.blockIdx)

        var newBlocks = blocks
        newBlocks[move.blockIdx] = newBlock

        return GameState(
            game: self.game,
            zhashTable: self.zhashTable,
            board: newBoard,
            move: move,
            blocks: newBlocks,
            hash: newHash,
            hashMirror: newHashMirror
        )
    }

}


//MARK: = GraphNode conformance for A-Star search implementation

extension GameState: GraphNode {

    var connectedNodes: [GameState] {
        let moves = blocks.enumerated().map { blockId, block in
            return block.allowedDirections.map{ dir in
                Move(blockIdx: blockId, direction: dir)
            }
            .filter { move  in
                board.can(block: blocks[move.blockIdx], move: move)
            }

        }.reduce([], +)

        return moves.compactMap(newStateWithPossibleMove)
        
    }

    var estimatedCostToDestination: Int {
        let masterBlockCurrentPosition = self.blocks[game.masterBlockIdx].position
        return abs(masterBlockCurrentPosition.column - game.masterGoalPosition.column) +
            abs(masterBlockCurrentPosition.row - game.masterGoalPosition.row)

    }

    func cost(to node: GameState) -> Int {
        return 1
    }

    var isGoal: Bool {
        return game.masterGoalPosition ==
            blocks[game.masterBlockIdx].position
    }

}
