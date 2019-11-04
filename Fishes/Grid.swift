//
//  Grid.swift
//  Peixes
//
//  Created by Elias Paulino on 03/11/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class Grid {
    var gridArray: [[GridElement]]
    
    var numberOfColumns: Int {
        return gridArray.first?.count ?? 0
    }
    
    var numberOfLines: Int {
        return gridArray.count
    }
    
    init(gridArray: [[GridElement]]) {
        self.gridArray = gridArray
    }
}
