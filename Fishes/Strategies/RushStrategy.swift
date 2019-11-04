//
//  RushStrategy.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class RushStrategy: WalkingStrategy {
    weak var scenario: Scenario?
    weak var fish: FishProtocol?
    
    var rushResponsabilityChain: WalkingResposabilityChain {
        var spendAllEnergyChain = SpendAllEnergyChain<FishJumpHabilityDecorator>(fish: self.fish, scenario: self.scenario)
        spendAllEnergyChain.nextChain = SpendAllEnergyChain<FishFowardHabilityDecorator>(fish: self.fish, scenario: self.scenario)
        spendAllEnergyChain.nextChain?.nextChain = SpendAllEnergyChain<FishAvoidHabilityDecorator>(fish: self.fish, scenario: self.scenario)
        
        return spendAllEnergyChain
    }
    
    func goAhead(withFish fish: FishProtocol, onScenario scenario: Scenario) {
        rushResponsabilityChain.run()
    }
    
    init(scenario: Scenario, fish: FishProtocol) {
        self.scenario = scenario
        self.fish = fish
    }
}
