//
//  WalkingResposabilityChain.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol WalkingResposabilityChain: ResponsabilityChain {
    var fish: FishProtocol? { get set }
    var scenario: Scenario? { get set }
    
    func tryApplying(forFish fish: FishProtocol, andScenario scenario: Scenario) -> Bool
}

extension WalkingResposabilityChain {
    func tryApplying() -> Bool {
        guard let fish = self.fish, let scenario = self.scenario else {
            return false
        }
        return self.tryApplying(forFish: fish, andScenario: scenario)
    }
}
