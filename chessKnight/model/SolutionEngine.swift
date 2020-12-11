//
//  SolutionEngine.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 9/12/20.
//

import Foundation

/// MetaCell as its name suggests, is a normal cell wrapper  with extra properties
class MetaCell{
    let previousCell: MetaCell?
    let numberOfMovesMade: Int
    let cell: Cell
    
    init(previousCell cell : MetaCell?, x xPosition : Int, y yPosition : Int, numberOfMovesMade num : Int) {
        self.previousCell = cell
        self.numberOfMovesMade = num
        self.cell = Cell(x: xPosition, y: yPosition)
    }
    
    func isEqual(cellToBeCompared cell : Cell ) -> Bool{
        return cell.xPosition == self.cell.xPosition && cell.yPosition == self.cell.yPosition
    }
    
    func hasMoreMoves() -> Bool{
        return numberOfMovesMade < 3
    }
    
    func getPath() -> Path{
        var cellVisitedList : [Cell] = []
        
        var currentCell : MetaCell? = self
        
        for _ in 1...numberOfMovesMade + 1{
            cellVisitedList.append(currentCell!.cell)
            currentCell = currentCell!.previousCell
        }
        
        return Path(cells: cellVisitedList)
    }
}


/// This engine is used to solve the problem. In release code this should probably run in a background thread. But because our problem is limited to 3 moves the execution time is small.
class SolutionEngine{
    
    func solve(knight : Knight, targetCell : Cell) -> [MetaCell]{
        if !isFastCheckPassed(knight: knight, targetCell: targetCell){return []}
        return solveBruteForceWay(knight: knight, targetCell: targetCell)
    }
    
    private func solveBruteForceWay(knight : Knight, targetCell : Cell) -> [MetaCell]{
        var satisfiedMetaCells : [MetaCell] = []
        let startingCell = MetaCell(previousCell: nil,
                                    x: knight.currentLocation.xPosition,
                                    y: knight.currentLocation.yPosition,
                                    numberOfMovesMade: 0)
        
        let virtualKnight = Knight(startingCell: knight.currentLocation, configurations: knight.configuration)
        
        // We've chosen a stack to do Depth First Search
        var data = Stack()
        data.push(startingCell)
        
        
        while !data.isEmpty(){
            let topInStackCell = data.peek()
            if !topInStackCell.hasMoreMoves(){
                if topInStackCell.isEqual(cellToBeCompared: targetCell){
                    satisfiedMetaCells.append(topInStackCell)
                }
                data.pop()
                continue
            }
            virtualKnight.currentLocation = topInStackCell.cell
            
            let validKnightMoves = virtualKnight.getValidMoves()
            let metaCells = convertCellsToMetacells(cellsList: validKnightMoves, previousCell: topInStackCell)
            data.pop()
            
            for metaCell in metaCells {
                data.push(metaCell)
            }
        }
        return satisfiedMetaCells
    }
    

    /// This is an optimization method to fastly check if there is no path solution. The complexity is O(1)
    private func isFastCheckPassed(knight : Knight, targetCell : Cell) -> Bool {
        if abs(targetCell.xPosition - knight.currentLocation.xPosition) > 6{
            return false
        }
        if abs(targetCell.yPosition - knight.currentLocation.yPosition) > 6{
            return false
        }
        if abs(targetCell.yPosition - knight.currentLocation.yPosition)
            + abs(targetCell.xPosition - knight.currentLocation.xPosition) > 9{
            return false
        }
        return true;
    }
    
    
    private func convertCellsToMetacells(cellsList : [Cell], previousCell : MetaCell) -> [MetaCell]{
        var metaCellList : [MetaCell] = []
        for cell in cellsList {
            metaCellList.append(MetaCell(previousCell: previousCell, x: cell.xPosition, y: cell.yPosition, numberOfMovesMade: previousCell.numberOfMovesMade + 1 ))
        }
        return metaCellList
    }
}
