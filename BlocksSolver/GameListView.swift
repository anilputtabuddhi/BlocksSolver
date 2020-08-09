//
//  GameListView.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 09/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import SwiftUI

struct GameListView: View {
    let games = Game.all

    var body: some View {
        NavigationView {
            List(games, id: \.desc) { game in
                NavigationLink(
                    destination: GameView(solver: BlocksMoveSolver(game: game)!)
                ) {
                    Text(game.desc)
                }
            }
            .navigationBarTitle("Games")
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
