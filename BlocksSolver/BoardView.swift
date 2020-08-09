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
    let masterBlocklabel: String
    let scaleFactor: CGFloat

    var body: some View {
        ZStack {
            Rectangle().frame(
                width: CGFloat(boardSize.columns) * scaleFactor + 5.0,
                height: CGFloat(boardSize.rows) * scaleFactor + 5.0
            )
            ForEach(blocks) { block in
                BlockView(
                    block: block,
                    boardSize: self.boardSize,
                    scaleFactor: self.scaleFactor,
                    isMaster: block.label == self.masterBlocklabel
                )
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(
            boardSize: Game.klotski.size,
            blocks: Game.klotskiBlocks,
            masterBlocklabel: Game.klotskiBlocks[0].label,
            scaleFactor: 60.0
        )
    }
}

