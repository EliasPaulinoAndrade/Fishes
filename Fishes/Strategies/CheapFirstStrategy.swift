//
//  CheapFirstStrategy.swift
//  Peixes
//
//  Created by Elias Paulino on 04/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class g: WalkingStrategy {
    weak var scenario: Scenario?
    weak var fish: FishProtocol?
    
    var cheapFirstStrategy: WalkingResposabilityChain {
        
        var cheapFirstStrategy = SpendAllEnergyChain<FishFowardHabilityDecorator>(fish: self.fish, scenario: self.scenario)
        cheapFirstStrategy.nextChain = SpendAllEnergyChain<FishAvoidHabilityDecorator>(fish: self.fish, scenario: self.scenario)
        cheapFirstStrategy.nextChain?.nextChain = SpendAllEnergyChain<FishJumpHabilityDecorator>(fish: self.fish, scenario: self.scenario)
        cheapFirstStrategy.nextChain?.nextChain?.nextChain = SpendAllEnergyChain<FishBlastRocksHabilityDecorator>(fish: self.fish, scenario: self.scenario)
        
        return cheapFirstStrategy
    }
    
    func goAhead(withFish fish: FishProtocol, onScenario scenario: Scenario) {
        cheapFirstStrategy.run()
    }
    
    init(scenario: Scenario, fish: FishProtocol) {
        self.scenario = scenario
        self.fish = fish
    }
}
