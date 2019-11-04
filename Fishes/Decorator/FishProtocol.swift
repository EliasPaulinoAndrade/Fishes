//
//  FishProtocol.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol FishProtocol: class {
    var energy: Int { get set }
    var positionX: Int? { get set }
    var positionY: Int? { get set }
    var identifier: String { get set }
    var walkStrategy: WalkingStrategy? { get set }
    
    func walk()
}

extension FishProtocol {
    func decorator<DecoratorType: FishHabilityDecorator>(ofType decoratorType: DecoratorType.Type) -> DecoratorType? {
        guard let selfAsDecorator = self as? FishHabilityDecorator else {
            return nil
        }
    
        var currentDecorator: FishHabilityDecorator = selfAsDecorator
        while true {
            if let decoratorAsGivenType = currentDecorator as? DecoratorType,
               type(of: currentDecorator) == decoratorType {
                return decoratorAsGivenType
            } else if let nextDecorator = currentDecorator.decoratedFish as? FishHabilityDecorator {
                currentDecorator = nextDecorator
            } else {
                return nil
            }
        }
    }
}
