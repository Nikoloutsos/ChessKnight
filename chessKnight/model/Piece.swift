//
//  Piece.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 9/12/20.
//

import Foundation

protocol Movable{
    func getValidMoves() -> [Cell];
}

protocol Piece: Movable{
    var currentLocation : Cell { get set }
}

