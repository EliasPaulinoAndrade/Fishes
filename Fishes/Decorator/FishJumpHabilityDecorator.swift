//
//  FishJumpHability.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class FishJumpHabilityDecorator: FishHabilityDecorator, HabilityStrategy {
    var maximunOfLines: Int
    var energyCost: Int = 50
    
    init(decoratedFish: FishProtocol, maximunOfLines: Int) {
        self.maximunOfLines = maximunOfLines
        super.init(decoratedFish: decoratedFish)
    }
    
    required init(decoratedFish: FishProtocol) {
        self.maximunOfLines = 1
        super.init(decoratedFish: decoratedFish)
    }
    
    func applyHability(ofFish fish: FishProtocol, inScenario scenario: Scenario) -> Bool {
        guard let jumpDestinyPosition = self.jumpDestinyPosition(forScenario: scenario, andFish: fish),
              let fishPositionX = fish.positionX else {
            return false
        }
        
        scenario.move(fish: fish, toPositionX: fishPositionX, positionY: jumpDestinyPosition)
        fish.energy -= energyCost
        
        return true
    }
    
    private func jumpDestinyPosition(forScenario scenario: Scenario, andFish fish: FishProtocol) -> Int? {
        guard let positionY: Int = fish.positionY, let posiitonX: Int = fish.positionX else {
            return nil
        }
        
        let jumpDestinyPositionY = (2...(self.maximunOfLines + 1)).filter { (currentJumpDistance) -> Bool in
            let jumpDestinyPositionY = positionY - currentJumpDistance
            let destinyFitsOnGrid = scenario.grid.numberOfLines > jumpDestinyPositionY && jumpDestinyPositionY >= 0
            guard destinyFitsOnGrid else {
                return false
            }
            let destityPositionElement = scenario.grid.gridArray[jumpDestinyPositionY][posiitonX]
            
            switch destityPositionElement {
                case .empty:
                    return true
                case .fish(_), .obstacle:
                    return false
            }
        }.last
        
        if let safeJumpDestiny = jumpDestinyPositionY {
            return positionY - safeJumpDestiny
        }
        return nil
    }
}
