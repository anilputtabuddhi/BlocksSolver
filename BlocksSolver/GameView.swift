//
//  GameView.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 07/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import SwiftUI

struct GameView: View {

    let game: Game
    var masterBlocklabel: String {
        let masterBlock = game.blocks[game.masterBlockIdx]
        return masterBlock.label
    }

    @State var gameStates: [GameState]
    @State var index: Int = 0
    @State var loading  = true
    @State var failed  = false


    var body: some View {
        VStack(spacing: 20) {
            Text(game.desc)
                .font(.largeTitle)
            BoardView(
                boardSize: game.size,
                blocks: gameStates[index].blocks,
                masterBlocklabel: masterBlocklabel,
                scaleFactor: 60.0
            )

            if loading {
                Text("Loading Solution")
                .onAppear {
                    self.solve()
                }
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            } else if failed{
                Text("Failed in finding a solution")
                Button(action: {
                    self.loading = true
                }) {
                    Text("Try again")
                }

            } else {
                Text("Moves Remaining: \(gameStates.count - index - 1)")
                HStack(alignment: .top) {
                    Spacer()
                    Button(action: {
                        if self.index > 0 {
                            self.index = self.index - 1
                        }
                    }) {
                        Text("Previous Move")
                    }
                    Spacer()
                    Button(action: {
                        if self.index < self.gameStates.count - 1 {
                            self.index = self.index + 1
                        }
                    }) {
                        Text("Next Move")
                    }
                    Spacer()
                }
            }
        }
    }

    private func solve() {
        DispatchQueue.global(qos: .background).async {
            let solver = BlocksMoveSolver(game: self.game)!
            DispatchQueue.main.async {
                switch solver.solve() {
                case .success(let gStates):
                    self.gameStates = gStates
                    self.loading = false
                case .failure:
                    self.failed = true
                    self.loading = false
                }
            }

        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(
            game: Game.klotski,
            gameStates: [GameState.createInitialStateWith(game: Game.klotski)!]
        )
    }
}


struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
