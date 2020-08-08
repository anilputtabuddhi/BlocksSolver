//
//  Move.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 06/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct Move: Equatable {
    let blockIdx: Int
    let direction: Direction

    init(blockIdx: Int, direction: Direction) {
        self.blockIdx = blockIdx
        self.direction = direction
    }
}

enum Direction: Int, CaseIterable {
    case down = 0
    case right = 1
    case up = 2
    case left = 3

    func isReverseDirection(
        of thatDirection: Direction
    ) -> Bool {
        return
            (rawValue + 2) % Direction.allCases.count == thatDirection.rawValue
    }

    static let allInCoordinates: [Coordinate] = [
        Coordinate(x: 0, y: 1), //down
        Coordinate(x: 1, y: 0), //right
        Coordinate(x: 0, y: -1), //up
        Coordinate(x: -1, y: 0) //left
    ]
}

struct Coordinate {
    let x: Int
    let y: Int
}
