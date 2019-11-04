//
//  ChainOfResponsability.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol ResponsabilityChain {
    var nextChain: ResponsabilityChain? { get set }
    
    func tryApplying() -> Bool
}

extension ResponsabilityChain {
    func run() {
        if !self.tryApplying() {
            self.nextChain?.run()
        }
    }
}
