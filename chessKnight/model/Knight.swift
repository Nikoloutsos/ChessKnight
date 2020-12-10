//
//  Knight.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 9/12/20.
//

import Foundation


class Knight: Piece{
    var currentLocation: Cell
    var configuration: Configuration
    
    init(startingCell location: Cell, configurations conf: Configuration) {
        self.currentLocation = location
        self.configuration = conf
    }
    
    func getValidMoves() -> [Cell] {
        var validMovesList : [Cell] = []
        
        let curX = currentLocation.xPosition
        let curY = currentLocation.yPosition
        
        
        if isMoveWithinBounds(x: curX + 2, y: curY + 1){
            validMovesList.append(Cell(x: curX + 2, y: curY + 1))
        }
        if isMoveWithinBounds(x: curX + 2, y: curY - 1){
            validMovesList.append(Cell(x: curX + 2, y: curY - 1))
        }
        if isMoveWithinBounds(x: curX - 2, y: curY + 1){
            validMovesList.append(Cell(x: curX - 2, y: curY + 1))
        }
        if isMoveWithinBounds(x: curX - 2, y: curY - 1){
            validMovesList.append(Cell(x: curX - 2, y: curY - 1))
        }
        
        if isMoveWithinBounds(x: curX + 1, y: curY + 2){
            validMovesList.append(Cell(x: curX + 1, y: curY + 2))
        }
        if isMoveWithinBounds(x: curX + 1, y: curY - 2){
            validMovesList.append(Cell(x: curX + 1, y: curY - 2))
        }
        if isMoveWithinBounds(x: curX - 1, y: curY + 2){
            validMovesList.append(Cell(x: curX - 1, y: curY + 2))
        }
        if isMoveWithinBounds(x: curX - 1, y: curY - 2){
            validMovesList.append(Cell(x: curX - 1, y: curY - 2))
        }
        
        return validMovesList
    }
    
    
    private func isMoveWithinBounds(x : Int, y : Int) -> Bool{
        if x < 0 || x > configuration.sizeOfChessBoard - 1{
            return false
        }
        if y < 0 || y > configuration.sizeOfChessBoard - 1{
            return false
        }
        return true
    }
    
}
