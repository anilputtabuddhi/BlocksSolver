//
//  Solver.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 06/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

class BlocksMoveSolver {

    let game: Game
    private(set) var states: [GameState] = []
    private let zhashTable: ZobritHashTable

    init?(game: Game) {
        self.game = game
        self.zhashTable = ZobritHashTable.createFor(game: game)

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

        let initialState = GameState(
            game: game,
            hashProvider: zhashTable.getZobristHashUpdates,
            board: board,
            move: nil,
            blocks: game.blocks,
            hash: hash,
            hashMirror: hashMirror
        )

        self.states.append(initialState)
    }
}

// Mark: - Public Interface

extension BlocksMoveSolver {
    func solve() -> Bool {

        let solutionStates = states[0].findPathToGoal()
        if solutionStates.count == 0{
            return false
        }

        var optimisedSolutionStates = Array(solutionStates.prefix(2))

        for solutionState in Array(solutionStates.dropFirst(2)) {
            if let previousMove = optimisedSolutionStates.last?.move,
                let currentMove = solutionState.move,
                previousMove.direction == currentMove.direction &&
                    previousMove.blockIdx == currentMove.blockIdx {
                optimisedSolutionStates.removeLast()
            }
            optimisedSolutionStates.append(solutionState)
        }

        self.states = optimisedSolutionStates
        return true
    }
}
