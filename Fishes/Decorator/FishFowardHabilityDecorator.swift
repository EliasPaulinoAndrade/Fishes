//
//  FishFowardHabilityDecorator.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class FishFowardHabilityDecorator: FishHabilityDecorator, HabilityStrategy {
    var energyCost: Int = 5
    
    func applyHability(ofFish fish: FishProtocol, inScenario scenario: Scenario) -> Bool {
        guard let positionX = fish.positionX, let positionY = fish.positionY,
              positionY >= 1 else {
            return false
        }
        
        switch scenario.grid.gridArray[positionY - 1][positionX] {
        case .empty:
            scenario.move(fish: fish, toPositionX: positionX, positionY: positionY - 1)
            fish.energy -= energyCost
            return true
        case .obstacle, .fish:
            return false
        }
    }
}
