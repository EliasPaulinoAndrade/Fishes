//
//  LowEnergyStrategy.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class LowEnergyStrategy: WalkingStrategy {
    weak var scenario: Scenario?
    weak var fish: FishProtocol?
    
    var lowEnergyResponsabilityChain: WalkingResposabilityChain {
        var spendAllEnergyChain = SaveEnergyChain<FishJumpHabilityDecorator>(fish: self.fish, scenario: self.scenario, percentage: 0.2)
        spendAllEnergyChain.nextChain = SpendAllEnergyChain<FishFowardHabilityDecorator>(fish: self.fish, scenario: self.scenario)
        spendAllEnergyChain.nextChain?.nextChain = SpendAllEnergyChain<FishAvoidHabilityDecorator>(fish: self.fish, scenario: self.scenario)

        return spendAllEnergyChain
    }

    func goAhead(withFish fish: FishProtocol, onScenario scenario: Scenario) {
        lowEnergyResponsabilityChain.run()
    }

    init(scenario: Scenario, fish: FishProtocol) {
        self.scenario = scenario
        self.fish = fish
    }
}

