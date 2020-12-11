//
//  Configuration.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 9/12/20.
//

import Foundation

class Configuration{
    let sizeOfChessBoard : Int
    let knightInitialPosition: Coordinate = Coordinate(x: 1, y: 1)
    let targetInitialPosition: Coordinate = Coordinate(x: 4, y: 3)
    
    init(sizeOfChessBoard n : Int) {
        self.sizeOfChessBoard = n;
    }
}
