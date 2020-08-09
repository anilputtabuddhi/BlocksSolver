//
//  BoardView.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 07/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import SwiftUI

struct BoardView: View {
    let boardSize: Size
    let blocks: [Block]
    let positions: [Position]
    let masterBlockId: Int
    let scaleFactor: CGFloat

    var masterBlock: Block {
            return blocks[masterBlockId]
    }

    var body: some View {
        ZStack {

            Rectangle()
                .fill(Color.white)
                .border(Color.black, width: 5)
                .frame(
                    width: CGFloat(boardSize.columns) * scaleFactor + 12.0,
                    height: CGFloat(boardSize.rows) * scaleFactor + 12.0
                )

            ForEach(blocks) { block in
                BlockView(
                    block: block,
                    position: self.positions[block.id],
                    boardSize: self.boardSize,
                    scaleFactor: self.scaleFactor,
                    fillColor: self.fillColorFor(block),
                    borderColor: self.borderColor(block)
                )
            }


        }
    }

    private func fillColorFor(_ block: Block) -> Color{
        if block.id == masterBlockId {
            return Color.blue
        }
        return Color.red
    }

    private func borderColor(_ block: Block) -> Color{
        if block.id == masterBlockId {
            return Color.white
        }
        return Color.white
    }
}



struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(
            boardSize: Game.klotski.size,
            blocks: Game.klotskiBlocks,
            positions: Game.klotskiBlockPositions,
            masterBlockId: Game.klotskiBlocks[0].id,
            scaleFactor: 60.0
        )
    }
}

