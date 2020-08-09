//
//  GameView.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 07/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import SwiftUI

struct GameView: View {

    let solver: BlocksMoveSolver

    @State var index: Int = 0
    @State var loading  = true
    @State var failed  = false

    private var remainingMoves: Int {
        return solver.states.count - index - 1
    }

    var body: some View {
        VStack() {
            BoardView(
                boardSize: solver.game.size,
                blocks: solver.game.blocks,
                positions: solver.states[index].positions,
                masterBlockId: solver.game.masterBlockIdx,
                scaleFactor: 60.0
            )
                .padding()
            if loading {
                VStack {
                    Text("Loading Solution")
                        .onAppear {
                            self.solve()
                    }
                    ActivityIndicator(
                        isAnimating: .constant(true),
                        style: .large
                    )
                }
                .padding()
            } else if failed{
                Text("Failed in finding a solution")
                Button(action: {
                    self.loading = true
                }) {
                    Text("Try again")
                }

            } else {
                HStack() {
                    Button(action: {
                        if self.index > 0 {
                            self.index = self.index - 1
                        }
                    }) {
                        Text("Previous")
                    }
                    .disabled(index == 0)
                    Spacer()
                    VStack{
                        Text("\(remainingMoves)")
                            .font(.largeTitle)
                        Text("\(remainingMoves == 1 ? "move": "moves") to goal")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                            .italic()
                    }
                    Spacer()
                    Button(action: {
                        self.index = self.index + 1
                    }) {
                        Text("Next")
                    }
                    .disabled(index == self.solver.states.count - 1 )
                }
                .padding()
                
            }
            Spacer()
        }
        .navigationBarTitle(solver.game.desc)
    }

    private func solve() {
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.solver.solve()
            DispatchQueue.main.async {
                if result {
                    self.loading = false
                } else {
                    self.failed = true
                    self.loading = false
                }
            }

        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(solver: BlocksMoveSolver(game: Game.klotski)!)
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(
        context: UIViewRepresentableContext<ActivityIndicator>
    ) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: UIViewRepresentableContext<ActivityIndicator>
    ) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
