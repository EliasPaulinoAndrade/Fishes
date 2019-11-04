//
//  FishAvoidHabilityDecorator.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class FishAvoidHabilityDecorator: FishHabilityDecorator, HabilityStrategy {
    var energyCost: Int = 10

    func applyHability(ofFish fish: FishProtocol, inScenario scenario: Scenario) -> Bool {
        guard let positionY: Int = fish.positionY,
              let validAvoidPosition = avoidDestinyPosition(forScenario: scenario, andFish: fish) else {
            return false
        }
        
        scenario.move(fish: fish, toPositionX: validAvoidPosition, positionY: positionY)
        fish.energy -= energyCost
        return true
    }
    
    private func avoidDestinyPosition(forScenario scenario: Scenario, andFish fish: FishProtocol) -> Int? {
        guard let positionY: Int = fish.positionY, let positionX: Int = fish.positionX else {
            return nil
        }
        
        if directionToNearestPassageInNextLine(inScenario: scenario, positionX: positionX, positionY: positionY) == 1, checkIfAvoidDestinyIsValid(forScenario: scenario, avoidDestiny: positionX + 1, positionY: positionY) {
            return positionX + 1
        } else if directionToNearestPassageInNextLine(inScenario: scenario, positionX: positionX, positionY: positionY) == -1, checkIfAvoidDestinyIsValid(forScenario: scenario, avoidDestiny: positionX - 1, positionY: positionY) {
            return positionX - 1
        }
        
        return nil
    }

    private func directionToNearestPassageInNextLine(inScenario scenario: Scenario, positionX: Int, positionY: Int) -> Int? {
        var distanceToNearestRightPassage: Int?
        var distanceToNearestLeftPassage: Int?
        
        for gridXDistance in (1...(scenario.grid.numberOfColumns - positionX + 1)) {
            let gridXPosition = gridXDistance + positionX
            if checkIfAvoidDestinyIsValid(forScenario: scenario, avoidDestiny: gridXPosition, positionY: positionY) {
                if (positionY - 1) >= 0, case GridElement.empty = scenario.grid.gridArray[positionY - 1][gridXPosition] {
                    distanceToNearestRightPassage = gridXDistance
                    break
                }
            } else {
                break
            }
        }
        
        for gridXDistance in (1...(positionX + 1)) {
            let gridXPosition = positionX - gridXDistance
            if checkIfAvoidDestinyIsValid(forScenario: scenario, avoidDestiny: gridXPosition, positionY: positionY) {
                if (positionY - 1) >= 0, case GridElement.empty = scenario.grid.gridArray[positionY - 1][gridXPosition] {
                    distanceToNearestLeftPassage = gridXDistance
                    break
                }
            } else {
                break
            }
        }
        
        if let safeDistanceToNearestRightPassage = distanceToNearestRightPassage {
            if let safeDistanceToNearestLeftPassage = distanceToNearestLeftPassage {
                return safeDistanceToNearestRightPassage <= safeDistanceToNearestLeftPassage ? 1 : -1
            } else {
                return 1
            }
        } else if distanceToNearestLeftPassage != nil {
            return -1
        } else {
            return nil
        }
    }

    private func checkIfAvoidDestinyIsValid(forScenario scenario: Scenario, avoidDestiny: Int, positionY: Int) -> Bool {
        let destinyFitsOnGrid = scenario.grid.numberOfColumns > avoidDestiny && avoidDestiny >= 0
        
        guard destinyFitsOnGrid else {
            return false
        }
        
        switch scenario.grid.gridArray[positionY][avoidDestiny] {
        case .empty:
            return true
        case .obstacle, .fish:
            return false
        }
    }
}
