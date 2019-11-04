//
//  FishEnergyPlusHability.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class FishEnergyPlusHabilityDecorator: FishHabilityDecorator {
    var plus: Int
    
    override var energy: Int {
        get {
            return decoratedFish.energy + plus
        } set {
            decoratedFish.energy = newValue - plus
        }
    }
    
    init(decoratedFish: FishProtocol, plus: Int) {
        self.plus = plus
        super.init(decoratedFish: decoratedFish)
    }
    
    required init(decoratedFish: FishProtocol) {
        self.plus = 100
        super.init(decoratedFish: decoratedFish)
    }
}
