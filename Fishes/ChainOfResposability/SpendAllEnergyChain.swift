//
//  SpendAllEnergyChain.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

struct SpendAllEnergyChain<HabilityType: FishHabilityDecorator & HabilityStrategy>: WalkingResposabilityChain, CustomStringConvertible {
    var fish: FishProtocol?
    var scenario: Scenario?
    var nextChain: ResponsabilityChain?
    
    var description: String {
        return "\(HabilityType.self) -> \(String(describing: nextChain))"
    }
        
    init(fish: FishProtocol?, scenario: Scenario?, nextChain: ResponsabilityChain? = nil) {
        self.fish = fish
        self.scenario = scenario
        self.nextChain = nextChain
    }
    
    func tryApplying(forFish fish: FishProtocol, andScenario scenario: Scenario) -> Bool {
        guard let fishWithHability = fish.decorator(ofType: HabilityType.self) else {
            return false
        }
        
        if fish.energy >= fishWithHability.energyCost, fishWithHability.applyHability(ofFish: fish, inScenario: scenario) {
            return true
        }
            
        return false
    }
}

