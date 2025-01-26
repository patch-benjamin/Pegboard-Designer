//
//  Item.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import Foundation
import SwiftData
//struct PegRow {
//    let columnCount: Int
//    var pegHoles: [PegHole]
//}
//struct PegColumn {
//    var rowCount: Int
//    var rows: [PegRow]
//}


import SwiftUI

@Model
final class ColorPallette {
    private var pallette: [UUID: String]
    
    init(colors: [UUID: String] = [:]) {
        self.pallette = colors
    }
    
    var colors: [Color] {
        pallette.values.sorted().map { Color(hex: $0) }
    }
    
    func updateColor(at id: UUID, with color: Color) {
        guard let hex = color.toHex() else { assertionFailure("Can't get hex on Update!") }
        pallette[id] = hex
    }
    func removeColor(at id: UUID) {
        pallette[id] = nil
    }
    func addColor(_ color: Color) {
        let newId = UUID()
        guard let hex = color.toHex() else { assertionFailure("Can't get hex on Creation!") }
        pallette[newId] = hex
    }
}



enum PegHole {
    case empty
    case filled(UUID)
}

@Model
final class Pegboard {
    private(set) var pegHoles: [[PegHole]]
    
    private(set) var rowCount: Int
    private(set) var pegsPerRow: Int
    
    var colors: [UUID]
    
    init(width: Int, height: Int, colors: [UUID]) {
        for _ in 0..<height {
            pegHoles.append(Array(repeating: .empty, count: width))
        }
        rowCount = pegHoles.count
        pegsPerRow = width
    }
    
    func row(at index: Int) -> [PegHole] {
        guard index < rowCount else {
            return []
        }
        return pegHoles[index]
    }
    
    func peg(row rowIndex: Int, index: Int) -> PegHole {
        let row = self.row(at: rowIndex)
        guard index < row.count else {
            assertionFailure("Invalid Index")
            return .empty
        }
        return row[index]
    }
}

@Model
final class PegColor {
    var hex: String
    private(set) var id: UUID

    init(hex: String, id: UUID) {
        self.hex = hex
        self.id = id
    }
}
