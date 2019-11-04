//
//  GameController.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

enum GameState: String {
    case free, step
}

class GameController {
    var scenario = Scenario()
    var state: GameState = .step
    
    var possibleHabilities: [FishHabilityDecorator.Type] = [
        FishJumpHabilityDecorator.self,
        FishAvoidHabilityDecorator.self,
        FishEnergyPlusHabilityDecorator.self,
        FishBlastRocksHabilityDecorator.self,
    ]
    
    func startRacing() {
        print(scenario)
        addHabilitiesToFished()
        manageState(state: self.state)
        while true {
            computeNextRound()
            print(scenario)
            addHabilitiesToFished()
            manageState(state: self.state)
        }
    }
    
    func addHabilitiesToFished() {
        self.scenario.fishes = self.scenario.fishes.map({ (fish) -> FishProtocol in
            guard let newHability = possibleHabilities.randomElement(),
                  fish.decorator(ofType: newHability) == nil,
                  let fishPositionX = fish.positionX,
                  let fishPositionY = fish.positionY else {
                print("\(fish.identifier) - Lost the turn")
                return fish
            }
            
            let newHabilityDecorator = newHability.init(decoratedFish: fish)
            fish.walkStrategy?.fish = newHabilityDecorator
            scenario.grid.gridArray[fishPositionY][fishPositionX] = .fish(newHabilityDecorator)
            
            print("\(fish.identifier) - Won \(newHability) - Hability")
            return newHabilityDecorator
        })
    }
    
    func manageState(state: GameState) {
        switch state {
        case .free:
            sleep(1)
        case .step:
            let command = readLine()
            self.state = GameState(rawValue: command ?? "") ?? self.state
        }
    }
    
    func computeNextRound() {
        scenario.fishes.forEach { (fish) in
            fish.walk()
        }
    }
}
