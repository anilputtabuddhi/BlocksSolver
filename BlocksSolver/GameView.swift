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
            Text("Blocks Solver v1.0")
                .font(.largeTitle)
            if loading {
                Text("Loading Solution")
                .onAppear {
                    self.solve(game: Game.klotski)
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
                Text("Moves Remaining: \(blockStates.count - index - 1)")
                BoardView(
                    boardSize: size,
                    blocks: blockStates[index],
                    masterBlocklabel: masterBlocklabel,
                    scaleFactor: 60.0
                )
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
                        if self.index < self.blockStates.count - 1 {
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

    private func solve(game: Game) {
        DispatchQueue.global(qos: .background).async {
            let solver = BlocksMoveSolver(game: game)!
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
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(
            size: Size(5, 4),
            masterBlocklabel: "B"
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
