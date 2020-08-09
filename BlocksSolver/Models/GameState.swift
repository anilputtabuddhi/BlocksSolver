//
//  State.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 05/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct GameState {
    let game: Game
    let hashProvider: (GameState, Move) -> (Int, Int)
    let board: Board
    let move: Move?
    let blocks: [Block]
    let hash: Int
    let hashMirror: Int
}

//MARK: - GraphNode conformance for A-Star search implementation
extension GameState: GraphNode {

    var connectedNodes: [GameState] {
        let moves = blocks.map { block in
            return block.allowedDirections.map{ dir in
                Move(blockIdx: block.id, direction: dir)
            }
            .filter { move  in
                board.can(block: block, move: move)
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

//MARK: - Private methods
extension GameState {
    private func newStateWithPossibleMove(_ move: Move) -> GameState {

        let (newHash, newHashMirror) = hashProvider(self, move)

        let block = blocks[move.blockIdx]
        let dir = Direction.allInCoordinates[move.direction.rawValue]
        let newBlock = block.withNewPosition(
            Position(
                block.position.row + dir.y,
                block.position.column + dir.x
            )
        )

        let newBoard = board.replace(block, with: newBlock)

        var newBlocks = blocks
        newBlocks[newBlock.id] = newBlock

        return GameState(
            game: self.game,
            hashProvider: self.hashProvider,
            board: newBoard,
            move: move,
            blocks: newBlocks,
            hash: newHash,
            hashMirror: newHashMirror
        )
    }
}
