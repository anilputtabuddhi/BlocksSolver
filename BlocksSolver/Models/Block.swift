//
//  Block.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 06/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct Block: Identifiable {
    let label: String
    let id: Int
    let size: Size
    let position: Position
    let allowedDirections: [Direction]

    init(
        _ label: String,
        id: Int,
        size: Size,
        position: Position,
        allowedDirections: [Direction] = Direction.allCases
    ) {
        self.label = label
        self.id = id
        self.size = size
        self.position = position
        self.allowedDirections = allowedDirections
    }

    func withNewPosition(_ position: Position) -> Block {
        Block(
            self.label,
            id: self.id,
            size: self.size,
            position: position,
            allowedDirections: allowedDirections
        )
    }
}
