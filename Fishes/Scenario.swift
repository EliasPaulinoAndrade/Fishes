//
//  Scenario.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class Scenario: CustomStringConvertible {
    var grid: Grid
    
    lazy var rushFish: FishProtocol = {
        let rushFish = FishFowardHabilityDecorator(decoratedFish: Fish(energy: 150, identifier: "🐠"))
        rushFish.walkStrategy = RushStrategy(scenario: self, fish: rushFish)
        
        return rushFish
    }()
    
    lazy var lowEnergyFish: FishProtocol = {
        let lowEnergyFish = FishFowardHabilityDecorator(decoratedFish: Fish(energy: 150, identifier: "🐡"))
        lowEnergyFish.walkStrategy = LowEnergyStrategy(scenario: self, fish: lowEnergyFish)
        
        return lowEnergyFish
    }()
    
    lazy var cheaperFirstFish: FishProtocol = {
        let cheaperFirstFish = FishFowardHabilityDecorator(decoratedFish: Fish(energy: 150, identifier: "🐟"))
        cheaperFirstFish.walkStrategy = CheapFirstStrategy(scenario: self, fish: cheaperFirstFish)
        
        return cheaperFirstFish
    }()
    
    lazy var fishes: [FishProtocol] = {
        return [rushFish, lowEnergyFish, cheaperFirstFish]
    }()
    
    var description: String {
        let gridDescription = grid.gridArray.reduce("") { (description, gridLine) -> String in
            gridLine.reduce(description) { (description, gridElement) -> String in
                return "\(description)\(gridElement)"
            } + "\n"
        }
        
        return gridDescription + fishes.reduce("", { (fishesDescription, fish) -> String in
            return fishesDescription + "\(fish) \n"
        })
    }
    
    init(grid: [[String]] = Constants.defaultGrid) {
        self.grid = Scenario.elementsGridFrom(stringGrid: grid)
        
        placeFishs()
    }
    
    init(grid: [[GridElement]]) {
        self.grid = Grid(gridArray: grid)
        
        placeFishs()
    }
    
    private func placeFishs() {
        guard self.fishes.count <= self.grid.numberOfColumns, self.fishes.count != 0 else {
            fatalError("The number of fished mut fit on the grid")
        }
        let spaceBetweenFished: Int = self.grid.numberOfColumns/self.fishes.count
        
        stride(from: 0, to: self.grid.numberOfColumns, by: spaceBetweenFished).enumerated().forEach { (strideElement) in
            guard strideElement.offset < self.fishes.count else {
                return
            }
            
            let fish = self.fishes[strideElement.offset]
            
            self.grid.move(fish: fish, toPositionX: strideElement.element, positionY: self.grid.numberOfLines - 1)
        }
    }
    
    private static func elementsGridFrom(stringGrid: [[String]]) -> Grid {
        var elementsGrid = stringGrid.map { (gridLine) -> [GridElement] in
            gridLine.map { (gridElementID) -> GridElement in
                return GridElement.element(fromString: gridElementID)
            }
        }
        elementsGrid.append(Array(repeating: GridElement.empty, count: stringGrid.first?.count ?? 0))
        
        return Grid(gridArray: elementsGrid)
    }
}

private enum Constants {
    static let defaultGrid = [
        ["⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"],
        ["❌", "❌", "⬛️", "❌", "❌", "⬛️", "⬛️"],
        ["⬛️", "❌", "⬛️", "⬛️", "⬛️", "❌", "❌"],
        ["⬛️", "❌", "❌", "⬛️", "⬛️", "⬛️", "❌"],
        ["⬛️", "❌", "⬛️", "❌", "❌", "⬛️", "❌"],
        ["⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"],
        ["❌", "⬛️", "❌", "⬛️", "❌", "❌", "⬛️"],
        ["❌", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "❌"],
        ["❌", "⬛️", "❌", "❌", "❌", "⬛️", "⬛️"],
        ["⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "❌"],
        ["❌", "❌", "⬛️", "❌", "❌", "⬛️", "❌"],
        ["⬛️", "❌", "⬛️", "⬛️", "⬛️", "❌", "⬛️"],
        ["⬛️", "❌", "❌", "⬛️", "⬛️", "⬛️", "⬛️"],
        ["⬛️", "❌", "⬛️", "⬛️", "❌", "⬛️", "⬛️"],
        ["⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "❌"],
        ["❌", "❌", "❌", "⬛️", "❌", "❌", "⬛️"],
        ["❌", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"],
        ["⬛️", "⬛️", "❌", "❌", "❌", "⬛️", "❌"],
        ["⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"]
    ]
}
