//
//  ViewControllerPresenter.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 11/12/20.
//

import Foundation

protocol ViewControllerPresenterView: class {
    func showNoPathFound()
    func showPathFound(pathList : [Path])
    func reRenderChessBoard()
}

class ViewControllerPresenter{
    weak var view: ViewControllerPresenterView?
    var game : Game?
    
    init(with view: ViewControllerPresenterView) {
        self.view = view
        
        
    }
    
    func initGame(conf: Configuration){
        
        let knightInitialCell = Cell(x: conf.knightInitialPosition.x, y: conf.knightInitialPosition.y)
        let targetInitialCell = Cell(x: conf.targetInitialPosition.x, y: conf.targetInitialPosition.y)

        let knight = Knight(startingCell: knightInitialCell, configurations: conf)
        game = Game(knight: knight, solutionEngine: SolutionEngine(), targetCell: targetInitialCell)
    }
    
    func onStartButtonPressed(){
        guard let game = self.game else{return}
        
        let allPathList = game.findAllPaths()
        if allPathList.count == 0{
            view?.showNoPathFound()
        }else{
            view?.showPathFound(pathList: allPathList)
        }
    }
    
    func changeChessBoardConfiguration(conf: Configuration){
        game?.changeConfiguration(conf: conf)
    }
}

extension ViewControllerPresenter : ChessBoardDelegate{
    func onConfigurationsChanged(conf: Configuration) {
        game?.changeConfiguration(conf: conf)
    }
    
    func onTargetPositionChanged(newLocation: Coordinate) {
        game?.changeTargetPosition(chessBoardCell: Cell(x: newLocation.x, y: newLocation.y))
    }
    
    func onKnightPositionChanged(newLocation: Coordinate) {
        let knightLocationCell = Cell(x: newLocation.x, y: newLocation.y)
        game?.changeKnightPosition(chessBoardCell: knightLocationCell)
    }
}
