//
//  ChessBoardDelegate.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 11/12/20.
//

import Foundation


protocol ChessBoardDelegate{
    func onTargetPositionChanged(newLocation : Coordinate)
    func onKnightPositionChanged(newLocation : Coordinate)
    func onConfigurationsChanged(conf : Configuration)
}
