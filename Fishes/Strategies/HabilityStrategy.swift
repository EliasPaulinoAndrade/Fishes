//
//  HabilityStrategy.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol HabilityStrategy {
    var energyCost: Int { get set }
    
    func applyHability(ofFish fish: FishProtocol, inScenario scenario: Scenario) -> Bool
}
