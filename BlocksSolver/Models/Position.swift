//
//  Position.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 06/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct Position: Equatable {
    let row: Int
    let column: Int

    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }

    func newPositionBy(movingTo direction: Direction) -> Position {
        let dir = Direction.allInCoordinates[direction.rawValue]
        return Position(
            row + dir.y,
            column + dir.x
        )
    }
}
