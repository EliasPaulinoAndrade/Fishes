//
//  Strategy.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol WalkingStrategy {
    var fish: FishProtocol? { get set }
    var scenario: Scenario? { get set }
    
    func goAhead(withFish fish: FishProtocol, onScenario scenario: Scenario)
}

extension WalkingStrategy {
    func walk() {
        guard let fish = self.fish, let scenario = self.scenario else {
            return
        }
        goAhead(withFish: fish, onScenario: scenario)
    }
}
