//
//  Pegboard.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftData
import Foundation

@Model
final class Pegboard {
    private var pegHoles: [[PegHole]]
    private(set) var designPallette: [UUID]
    
    var rows: [[PegHole]] {
        get {
            pegHoles
        } set {
            guard newValue.flatMap({ $0 }).count == pegHoles.flatMap({ $0 }).count else { return }
            pegHoles = newValue
        }
    }
    
    
    init(width: Int, height: Int, colors: [UUID]) {
        pegHoles = []
        self.designPallette = colors
        
        for _ in 0..<height {
            pegHoles.append(Array(repeating: .init(), count: width))
        }
    }
    
    func addColorIDsToPallette(_ colorIDs: [UUID]) {
        var setIDs = Set(designPallette)
        for id in colorIDs {
            if !setIDs.contains(id) {
                setIDs.insert(id)
                self.designPallette.append(id)
            }
        }
    }
    
}

struct PegHole: Identifiable, Codable {
    private(set) var id = UUID()
    var colorID: UUID?
    
    init(pegColor: UUID? = nil) {
        self.colorID = pegColor
    }
}
