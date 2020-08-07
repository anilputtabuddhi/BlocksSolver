//
//  Solver.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 06/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

enum BlocksSolverError: Error {
    case couldNotSolve
}

class BlocksMoveSolver {

    let zhashTable: ZobritHashTable
    let initialState: GameState
    let game: Game
    private var states: [GameState]
    private(set) var zhashLookup: [Int: Bool] = [:]

    init?(game: Game) {
        self.game = game

        let zTable = ZobritHashTable.createFor(game: game)
        guard let state = GameState.createInitialStateWith(
            game: game,
            zhashTable: zTable
        ) else {
                return nil
        }
        self.initialState = state
        self.states = [state]
        self.zhashTable = zTable
    }
}

// Mark: - Public Interface

extension BlocksMoveSolver {
    func solve() -> Result<[[Block]], BlocksSolverError> {

        var index = 0

        while (index < states.count) {
            let state = states[index]
            index = index + 1
            zhashLookup[state.hash] = true
            zhashLookup[state.hashMirror] = true

            if isMasterInGoalPosition(state) {
                return .success(getAllBlockPositionsToSolutionFrom(state))
            } else {
                searchNewStatesFrom(state)
            }
        }

        return .failure(.couldNotSolve)
    }
}

// MARK: - Private Helpers

extension BlocksMoveSolver {

    private func isMasterInGoalPosition(_ state: GameState) -> Bool {
        return game.masterGoalPosition ==
            state.blocks[game.masterBlockIdx].position
    }

    private func getAllBlockPositionsToSolutionFrom(_ gameState: GameState) -> [[Block]]{
        var state: GameState? = gameState
        var allStateBlocks: [[Block]] = []
        while (state != nil) {
            allStateBlocks.append(state!.blocks)
            state = state!.parent
        }
        return allStateBlocks.reversed()
    }

    private func getMovesFrom(_ gameState: GameState) -> [Move]{
        var state: GameState? = gameState
        var moves: [Move] = []
        while (state != nil) {
            if (state!.step > 0) {
                moves.append(state!.moveFromParent!)
            }
            state = state!.parent
        }
        return moves.reversed()
    }

    private func searchNewStatesFrom(_ state: GameState) {

        let blockMoves = state.blocks.enumerated().map { id, _ in
            Direction.allCases.map{ dir in
                Move(blockIdx: id, direction: dir)

            }
        }.reduce([], +)

        let newPossibleStates = blockMoves.compactMap{
            state.newStateWithPossibleMove(
                move: $0,
                zhashTable: zhashTable,
                zhashLookup: zhashLookup
            )
        }

        newPossibleStates.forEach(pushNewStateIfAlreadyNotVisited)

    }
    
    private func pushNewStateIfAlreadyNotVisited(_ state: GameState)  {
        guard zhashLookup[state.hash] != true,
            zhashLookup[state.hashMirror] != true else {
                return 
        }

        zhashLookup[state.hash] = true
        zhashLookup[state.hashMirror] = true
        states.append(state)
    }
}
