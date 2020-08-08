//
//  Block.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 06/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct Block {
    let label: String
    let size: Size
    let position: Position
    let allowedDirections: [Direction]

    init(
        _ label: String,
        size: Size,
        position: Position,
        allowedDirections: [Direction] = Direction.allCases
    ) {
        self.label = label
        self.size = size
        self.position = position
        self.allowedDirections = allowedDirections
    }

    func withNewPosition(_ position: Position) -> Block {
        Block(
            self.label,
            size: self.size,
            position: position,
            allowedDirections: allowedDirections
        )
    }
}
