//
//  FishHability.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class FishHabilityDecorator: FishProtocol, CustomStringConvertible {
    var decoratedFish: FishProtocol
    var description: String {
        return "FISH \(identifier) - Energy: \(energy)"
    }
    
    var energy: Int {
        get {
            return decoratedFish.energy
        } set {
            self.decoratedFish.energy = newValue
        }
    }
    var positionX: Int? {
        get {
            return decoratedFish.positionX
        } set {
            self.decoratedFish.positionX = newValue
        }
    }
    var positionY: Int? {
        get {
            return decoratedFish.positionY
        } set {
            self.decoratedFish.positionY = newValue
        }
    }
    var identifier: String {
        get {
            return decoratedFish.identifier
        } set {
            self.decoratedFish.identifier = newValue
        }
    }
    var walkStrategy: WalkingStrategy? {
        get {
            return decoratedFish.walkStrategy
        } set {
            self.decoratedFish.walkStrategy = newValue
        }
    }
    
    required init(decoratedFish: FishProtocol) {
        self.decoratedFish = decoratedFish
    }
    
    func walk() {
        self.decoratedFish.walk()
    }
}
