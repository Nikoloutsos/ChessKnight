//
//  Game.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 9/12/20.
//

import Foundation

class Game{
    var knight : Knight
    var targetCell: Cell
    var engine: SolutionEngine
    
    init(knight : Knight, solutionEngine: SolutionEngine, targetCell : Cell) {
        self.knight = knight
        self.engine = solutionEngine
        self.targetCell = targetCell
    }
    
    func changeKnightPosition(chessBoardCell cell : Cell){
        knight.currentLocation = cell
    }
    
    func changeTargetPosition(chessBoardCell cell : Cell){
        targetCell = cell;
    }
    
    func changeConfiguration(conf : Configuration){
        knight.configuration = conf
    }
    
    func findAllPaths() -> [Path]{
        var pathFoundList : [Path] = []
        let metaCellList = engine.solve(knight: knight, targetCell: targetCell)
        
        for curMetaCell in metaCellList{
            pathFoundList.append(curMetaCell.getPath())
        }
        
        return pathFoundList
    }
}
