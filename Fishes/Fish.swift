//
//  Fish.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class Fish: FishProtocol, CustomStringConvertible {
    var energy: Int
    var positionX: Int?
    var positionY: Int?
    
    var identifier: String
    var walkStrategy: WalkingStrategy?
    
    var description: String {
        return "FISH \(identifier) - Energy: \(energy)"
    }
    
    init(energy: Int, identifier: String) {
        self.identifier = identifier
        self.energy = energy
    }
    
    func walk() {
        walkStrategy?.walk()
    }
}

