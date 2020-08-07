//
//  GameView.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 07/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import SwiftUI

struct GameView: View {
    let size: Size
    let masterBlocklabel: String
    @State var blockStates: [[Block]] = []
    @State var index: Int = 0
    @State var loading: Bool = true
    @State var failed: Bool = false

    var body: some View {
        VStack {
            if loading {
                Text("Loading Solution")
                .onAppear {
                    DispatchQueue.global(qos: .background).async {
                        let solver = BlocksMoveSolver(game: Game.klotski)!
                        DispatchQueue.main.async {
                            switch solver.solve() {
                            case .success(let blocks):
                                self.blockStates = blocks
                                self.loading = false
                            case .failure:
                                self.failed = true
                            }
                        }

                    }
                }
            } else if failed{
                Text("Failed in finding a solution")
                Button(action: {
                    self.loading = true
                }) {
                    Text("Try again")
                }

            } else {
                Text("Moves Remaining: \(blockStates.count - index - 1)")
                BoardView(
                    boardSize: size,
                    blocks: blockStates[index],
                    masterBlocklabel: masterBlocklabel,
                    scaleFactor: 40.0
                )
                Button(action: {
                    if self.index < self.blockStates.count - 1 {
                        self.index = self.index + 1
                    }
                }) {
                    Text("Next Move")
                }
            }
        }
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(
//            gameViewState: .loading
//        )
//    }
//}
