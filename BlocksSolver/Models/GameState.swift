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
    let positions: [Position]
    let hash: Int
    let hashMirror: Int
}

//MARK: - GraphNode conformance for A-Star search implementation
extension GameState: GraphNode {

    var connectedNodes: [GameState] {
        return game.blocks.map(\.allowedMoves)
            .reduce([], +)
            .filter { move in
                board.canBlock(move, from: positions[move.block.id])
            }
            .map(newStateWithPossibleMove)
    }

    var estimatedCostToDestination: Int {
        let masterBlockCurrentPosition = self.positions[game.masterBlockIdx]
        return abs(masterBlockCurrentPosition.column - game.masterGoalPosition.column) +
            abs(masterBlockCurrentPosition.row - game.masterGoalPosition.row)

    }

    func cost(to node: GameState) -> Int {
        return 1
    }

    var isGoal: Bool {
        return game.masterGoalPosition == positions[game.masterBlockIdx]
    }

}

//MARK: - Private methods
extension GameState {
    private func newStateWithPossibleMove(_ move: Move) -> GameState {

        let (newHash, newHashMirror) = hashProvider(self, move)
        let block = move.block
        let position = positions[block.id]
        let newPosition = position.newPositionBy(movingTo: move.direction)
        let newBoard = board.move(block, from: position, to: newPosition)
        var newPositions = positions
        newPositions[block.id] = newPosition

        return GameState(
            game: self.game,
            hashProvider: self.hashProvider,
            board: newBoard,
            move: move,
            positions: newPositions,
            hash: newHash,
            hashMirror: newHashMirror
        )
    }
}
