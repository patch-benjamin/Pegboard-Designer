//
//  ColorPallette.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftData
import SwiftUI

@Model
final class ColorPallette {
    var pallette: [ColorOption]
    
    init() {
        self.pallette = []
    }
    
    var colors: [Color] {
        pallette.map({ $0.color })
    }

    func addColor(_ color: Color) {
        pallette.append(.init(color: color))
    }
}

// MARK: - ColorOption

struct ColorOption: Identifiable {
    let id = UUID()
    var hex: String
    var color: Color { Color(hex: hex) }
    
    init(color: Color) {
        guard let hex = color.toHex() else {
            assertionFailure("Unable to initialize ColorOption from Color - unable to get hex")
            self.hex = "#000000"
        }
        self.hex = hex
    }
    
}

