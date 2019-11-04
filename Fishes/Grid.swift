//
//  Grid.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class Grid {
    var gridArray: [[GridElement]]
    
    var numberOfColumns: Int {
        return gridArray.first?.count ?? 0
    }
    
    var numberOfLines: Int {
        return gridArray.count
    }
    
    init(gridArray: [[GridElement]]) {
        self.gridArray = gridArray
    }
    
    func move(fish: FishProtocol, toPositionX positionX: Int, positionY: Int) {
         if let fishPositionY = fish.positionY, let fishPositionX = fish.positionX {
             self.gridArray[fishPositionY][fishPositionX] = .empty
         }
         fish.positionX = positionX
         fish.positionY = positionY
         self.gridArray[positionY][positionX] = .fish(fish)
    }
    
    func removeElement(fromPositionX positionX: Int, positionY: Int) {
        self.gridArray[positionY][positionX] = .empty
    }
}
