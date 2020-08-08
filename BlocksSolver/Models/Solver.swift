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

    private var states: [GameState]

    init?(game: Game) {
        guard let state = GameState.createInitialStateWith(game: game) else {
            return nil
        }
        self.states = [state]
    }
}

// Mark: - Public Interface

extension BlocksMoveSolver {
    func solve() -> Result<[GameState], BlocksSolverError> {

        let solutionStates = states[0].findPathToGoal()
        if solutionStates.count == 0{
            return .failure(.couldNotSolve)
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

        return .success(optimisedSolutionStates)
    }
}
