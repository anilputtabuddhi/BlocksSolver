//
//  Block.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 06/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct Block: Identifiable, Equatable {
    let label: String
    let id: Int
    let size: Size
    let allowedDirections: [Direction]

    init(
        _ label: String,
        id: Int,
        size: Size,
        allowedDirections: [Direction] = Direction.allCases
    ) {
        self.label = label
        self.id = id
        self.size = size
        self.allowedDirections = allowedDirections
    }

    var allowedMoves: [Move]  {
        return allowedDirections.map { direction in
            Move(self, direction)
        }
    }

}
