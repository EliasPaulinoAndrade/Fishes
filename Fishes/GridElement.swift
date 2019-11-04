//
//  GridElement.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

enum GridElement: CustomStringConvertible {
    case empty, obstacle, fish(FishProtocol)
    
    var description: String {
        switch self {
        case .empty:
            return "⬛️"
        case .obstacle:
            return "❌"
        case .fish(let fish):
            return fish.identifier
        }
    }
    
    static func element(fromString stringID: String) -> GridElement {
        switch stringID {
        case "⬛️":
            return .empty
        case "❌":
            return .obstacle
        default:
            return .empty
        }
    }
}
