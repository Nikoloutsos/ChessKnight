//
//  Stack.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 9/12/20.
//

import Foundation

struct Stack {
    private var items: [MetaCell] = []
    
    func peek() -> MetaCell {
        guard let topElement = items.first else { fatalError("This stack is empty.") }
        return topElement
    }
    
    mutating func pop() {
        items.removeFirst()
    }
  
    mutating func push(_ element: MetaCell) {
        items.insert(element, at: 0)
    }
    
    func isEmpty() -> Bool{
        return items.count == 0
    }
}
