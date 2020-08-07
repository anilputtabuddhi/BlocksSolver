//
//  State.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 05/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

class GameState {
    let parent: GameState?
    let blocks: [Block]
    let board: Board
    var step: Int
    let moveFromParent: Move?
    let hash: Int
    let hashMirror: Int

    init(
        parent: GameState? = nil,
        blocks: [Block],
        board: Board,
        step: Int,
        moveFromParent: Move? = nil,
        hash: Int,
        hashMirror: Int
    ){
        self.parent = parent
        self.blocks = blocks
        self.board = board
        self.step = step
        self.moveFromParent = moveFromParent
        self.hash = hash
        self.hashMirror = hashMirror
    }

    static func createInitialStateWith(
        game: Game,
        zhashTable: ZobritHashTable
    ) -> GameState? {

        guard let board = Board.createBoard(for: game.size, with: game.blocks) else {
            return nil
        }

        let (hash, hashMirror) = zhashTable.getZobristHash(
            blocks: game.blocks,
            blockSizeTypes: game.blockSizeTypes,
            gameSize: game.size,
            board: board
        )

        return GameState(
            blocks: game.blocks,
            board: board,
            step: 0,
            hash: hash,
            hashMirror: hashMirror
        )
    }

}

extension GameState {

    func newStateWithPossibleMove(
         move: Move,
         zhashTable: ZobritHashTable,
         zhashLookup: [Int: Bool]
    ) -> GameState? {
         let block = blocks[move.blockIdx]
         guard board.can(block: block, move: move) else {
             return nil
         }

         let (newHash, newHashMirror) = zhashTable.getZobristHashUpdates(
             state: self,
             move: move
         )

         guard zhashLookup[newHash] != true,
             zhashLookup[newHashMirror] != true
         else {
             return nil
         }

         var newBoard = board
         let dir = Direction.allInCoordinates[move.direction.rawValue]

         newBoard = newBoard.remove(block)

         let newBlock = block.withNewPosition(
             Position(
                 block.position.row + dir.y,
                 block.position.column + dir.x
             )
         )

         newBoard = newBoard.placeBlock(newBlock, with: move.blockIdx)

         var newBlocks = blocks
         newBlocks[move.blockIdx] = newBlock

         let newStep = step + 1

         return GameState(
             parent: self,
             blocks: newBlocks,
             board: newBoard,
             step: newStep,
             moveFromParent: move,
             hash: newHash,
             hashMirror: newHashMirror
         )
     }
}
