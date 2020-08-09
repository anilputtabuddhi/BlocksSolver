//
//  BlockView.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 07/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import SwiftUI

struct BlockView: View {
    let block: Block
    let position: Position
    let boardSize: Size
    let scaleFactor: CGFloat
    let fillColor: Color
    let borderColor: Color

    var body: some View {
        Text("\(block.label)")
            .frame(
                width: CGFloat(block.size.columns) * scaleFactor,
                height: CGFloat(block.size.rows) * scaleFactor
            )
            .background(fillColor)
            .border(borderColor, width: 1)
            .offset(x: xOffsetFor(block), y: yOffsetFor(block))
            .shadow(radius: 2)

    }

    private var boardCenter: CGPoint {
        return CGPoint(
            x: CGFloat(boardSize.columns) * scaleFactor / 2.0,
            y: CGFloat(boardSize.rows) * scaleFactor / 2.0
        )
    }

    private var blockCenter: CGPoint {
        let centerX = ( CGFloat(position.column) +
            CGFloat(block.size.columns) / 2.0) * scaleFactor
        let centerY = ( CGFloat(position.row) +
            CGFloat(block.size.rows) / 2.0) * scaleFactor

        return CGPoint(x: centerX, y: centerY)
    }

    private func xOffsetFor(_ block: Block) -> CGFloat {
        return blockCenter.x - boardCenter.x
    }

    private func yOffsetFor(_ block: Block) -> CGFloat {
        return blockCenter.y - boardCenter.y
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(
            block: Block(
                "A",
                id: 0,
                size: Size(3, 1)
            ),
            position: Position(0, 0),
            boardSize: Size(5, 6),
            scaleFactor: 40,
            fillColor: Color.clear,
            borderColor: Color.blue
        )
    }
}
