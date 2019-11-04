//
//  FishBlastRocksHabilityDecorator.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class FishBlastRocksHabilityDecorator: FishHabilityDecorator, HabilityStrategy {
    var energyCost = 100
    
    func applyHability(ofFish fish: FishProtocol, inScenario scenario: Scenario) -> Bool {
        guard let positionX = fish.positionX,
              let positionY = fish.positionY else {
            return false
        }
                
        guard blastIsValid(forScenario: scenario, positionX: positionX, positionY: positionY) else {
            return false
        }
        
        (1...3).forEach { (blastYDistance) in
            let blastYPosition = positionY - blastYDistance
            scenario.grid.removeElement(fromPositionX: positionX, positionY: blastYPosition)
        }
        
        scenario.grid.move(fish: fish, toPositionX: positionX, positionY: positionY - 3)
        
        fish.energy -= energyCost
        
        return true
    }
    
    private func blastIsValid(forScenario scenario: Scenario, positionX: Int, positionY: Int) -> Bool {
        (1...3).reduce(true) { (blastIsValid, blastYDistance) -> Bool in
            let blastYPosition = positionY - blastYDistance
            guard blastYPosition >= 0 else {
                return false
            }
            
            switch scenario.grid.gridArray[blastYPosition][positionX] {
            case .empty, .obstacle:
                return true && blastIsValid
            case .fish:
                return false
            }
        }
    }
}
