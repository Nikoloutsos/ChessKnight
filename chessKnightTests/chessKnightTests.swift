//
//  chessKnightTests.swift
//  chessKnightTests
//
//  Created by Konstantinos Nikoloutsos on 10/12/20.
//

import XCTest
@testable import chessKnight


class chessKnightTests: XCTestCase {
    var engine : SolutionEngine!
    var knight : Knight!
    var conf : Configuration!
    var game : Game!

    override func setUpWithError() throws {
        let cell = Cell(x: 0, y: 0)
        conf = Configuration(sizeOfChessBoard: 6)
        knight = Knight(startingCell: cell, configurations: conf)
        engine = SolutionEngine()
    }

    func test_solutionEngine_diagonalInput_shouldReturnEmptyList() throws {
        
        let result = engine.solve(knight: knight, targetCell: Cell(x: 1,y: 1))
        XCTAssertEqual(result.count, 0)
        
        let result2 = engine.solve(knight: knight, targetCell: Cell(x: 2,y: 2))
        XCTAssertEqual(result2.count, 0)
    }
    
    func test_solutionEngine_farAwayInput_shouldReturnEmptyList() throws {
    
        let result = engine.solve(knight: knight, targetCell: Cell(x: 5,y: 6))
        XCTAssertEqual(result.count, 0)
        
        let result2 = engine.solve(knight: knight, targetCell: Cell(x: 6,y: 5))
        XCTAssertEqual(result2.count, 0)
    }

    func test_solutionEngine_samePlace_shouldReturnEmptyList() throws {
        
        let result = engine.solve(knight: knight, targetCell: Cell(x: 0,y: 0))
        XCTAssertEqual(result.count, 0)
    }
    
    func test_solutionEngine_inputWith2Paths_shouldReturn2Paths() throws{
        let result = engine.solve(knight: knight, targetCell: Cell(x: 0,y: 5))
        XCTAssertEqual(result.count, 2)
    }
}
