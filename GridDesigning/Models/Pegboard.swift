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
    private var _pegHoles: [[PegHole]]
    var designPallette: [UUID]
    
    var pegHoles: [[PegHole]] {
        get {
            _pegHoles
        } set {
            guard newValue.flatMap({ $0 }).count == _pegHoles.flatMap({ $0 }).count else { return }
            _pegHoles = newValue
        }
    }
    
    init(width: Int, height: Int, colors: [UUID]) {
        _pegHoles = []
        self.designPallette = colors
        
        for _ in 0..<height {
            _pegHoles.append(Array(repeating: .init(), count: width))
        }
    }
    
}

struct PegHole: Identifiable, Codable {
    private(set) var id = UUID()
    var pegColor: UUID?
    
    init(pegColor: UUID? = nil) {
        self.pegColor = pegColor
    }
}
