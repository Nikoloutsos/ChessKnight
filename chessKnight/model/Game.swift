//
//  Game.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 9/12/20.
//

import Foundation

class Game{
    var configuation : Configuration
    var knight : Knight
    var targetCell: Cell?
    var engine: SolutionEngine
    
    init(config conf : Configuration, knight : Knight, solutionEngine: SolutionEngine) {
        self.configuation = conf
        self.knight = knight
        self.engine = SolutionEngine()
    }
    
    func changeStartPosition(chessBoardCell cell : Cell){
        knight.currentLocation = cell
    }
    
    func changeTargetPosition(chessBoardCell cell : Cell){
        targetCell = cell;
    }
    
    func findAllPaths(){
        guard let targetCell = targetCell else {return}
        engine.solve(knight: knight, targetCell: targetCell)
    }
}
