//
//  ChessBoardUIView.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 10/12/20.
//

import UIKit

enum PieceType: String{
    case knight
    case flag
}

class Coordinate{
    let x: Int
    let y: Int
    
    init(x xPos: Int, y yPos: Int) {
        self.x = xPos
        self.y = yPos
    }
    
    func isSameCoordinate(with coordinate: Coordinate) -> Bool{
        return self.x == coordinate.x && self.y == coordinate.y
    }
}

/// A chessboard UIView with 2 pieces, a knight and a flag.
class ChessBoardUIView: UIView {
    var boardSize = 6
    
    ///It is calculated in runtime
    var cellSide : CGFloat = -1
    
    var locationOfKnight : Coordinate = Coordinate(x: 0, y: 0)
    var locationOfFlag : Coordinate = Coordinate(x: 0, y: 0)
    
    var delegate : ChessBoardDelegate? = nil
    
    var coordinateStartDragging : Coordinate?
    var typeOfPieceStartDragging : PieceType?

    override func draw(_ rect: CGRect) {
        cellSide = bounds.width * 1.0 / CGFloat(boardSize)
        
        for column in 0..<boardSize{
            for row in 0..<boardSize{
                drawSquare(at: Coordinate(x: column, y: row))
            }
        }
        
        drawKnight(at: locationOfKnight)
        drawFlag(at: locationOfFlag)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let firstTouch = touches.first!
        let location = firstTouch.location(in: self)
        
        let coordinateClicked = getSquareLocationByXandY(x: location.x, y: location.y)
    
        let isKnightDragged = coordinateClicked.isSameCoordinate(with: locationOfKnight)
        let isFlagDragged = coordinateClicked.isSameCoordinate(with: locationOfFlag)
        
        if  !isKnightDragged && !isFlagDragged {return}
        
        coordinateStartDragging = coordinateClicked
        if isKnightDragged{
            typeOfPieceStartDragging = .knight
        }else if isFlagDragged{
            typeOfPieceStartDragging = .flag
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let _ = self.coordinateStartDragging else{return}
        let firstTouch = touches.first!
        let location = firstTouch.location(in: self)
        let coordinateClicked = getSquareLocationByXandY(x: location.x, y: location.y)
        
        if(!isInputClickWithinViewBounds(x: location.x, y: location.y)){
            self.typeOfPieceStartDragging = nil
            self.coordinateStartDragging = nil
            return
        }
        
        if typeOfPieceStartDragging! == .knight{
            locationOfKnight = coordinateClicked
            delegate?.onKnightPositionChanged(newLocation: coordinateClicked)
        }else{
            locationOfFlag = coordinateClicked
            delegate?.onTargetPositionChanged(newLocation: coordinateClicked)
        }
        
        self.typeOfPieceStartDragging = nil
        self.coordinateStartDragging = nil
        setNeedsDisplay()
    }
    
    
    public func applyConfiguration(conf: Configuration){
        boardSize = conf.sizeOfChessBoard
        locationOfKnight = conf.knightInitialPosition
        locationOfFlag = conf.targetInitialPosition
        
        setNeedsDisplay()
    }
    
    private func drawFlag(at coordinate: Coordinate){
        let padding = 0.25 * cellSide
        
        let xToDraw = CGFloat(coordinate.x) * cellSide + padding
        let yToDraw = CGFloat(coordinate.y) * cellSide + padding
        
        let img = UIImage(named: "redflag")
        img?.draw(in: CGRect(x: xToDraw, y: yToDraw, width: cellSide/2, height: cellSide/2))
    }
    
    private func drawKnight(at coordinate: Coordinate){
        let xToDraw = CGFloat(coordinate.x) * cellSide
        let yToDraw = CGFloat(coordinate.y) * cellSide
        
        let img = UIImage(named: "unicorn")
        img?.draw(in: CGRect(x: xToDraw, y: yToDraw, width: cellSide, height: cellSide))
    }
    
    private func drawSquare(at coordinate: Coordinate){
        let xToDraw = CGFloat(coordinate.x) * cellSide
        let yToDraw = CGFloat(coordinate.y) * cellSide
        
        let box = UIBezierPath(rect: CGRect(x: xToDraw, y: yToDraw, width: cellSide, height: cellSide))
        
        let squareColor = getSquareColor(col: coordinate.x, row: coordinate.y)
        squareColor.setFill()
        box.fill()
    }
    
    private func getSquareColor(col: Int, row: Int) -> UIColor{
        return (col + row) % 2 == 0 ? UIColor.white : UIColor.darkGray
    }
    
    private func getSquareLocationByXandY(x: CGFloat, y: CGFloat) -> Coordinate{
        Coordinate(x: Int(x/cellSide), y: Int(y/cellSide))
    }
    
    private func isInputClickWithinViewBounds(x : CGFloat, y : CGFloat) -> Bool{
        return x <= bounds.width && y <= bounds.height
    }
}
