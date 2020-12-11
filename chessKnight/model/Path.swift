//
//  Path.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 10/12/20.
//

import Foundation

class Path{
    let path : [Cell]
    var algebraicNotation : String{
        get{
            var fullPathNotation = ""
            
            for cell in path{
                var move = "♞"
                move += ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P"][cell.xPosition]
                move += "\(cell.yPosition + 1)"
                
                fullPathNotation += " \(move) <- "
            }
            return String(fullPathNotation.dropLast(3))
        }
    }
    
    init(cells celllist: [Cell]) {
        self.path = celllist
    }
}
