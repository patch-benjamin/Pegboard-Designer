//
//  ColorPallette.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftData
import SwiftUI

@Observable
@dynamicMemberLookup
class UserPallette {
    static var current: UserPallette = UserPallette()
    static var context: ModelContext { GridDesigningApp.context }

    private var _pallette: _UserColorPallette

    private init() {
        let context = Self.context
        let allPallettes = try? context.fetch(FetchDescriptor<_UserColorPallette>())
        let firstPallette = allPallettes?.first ?? .init()
        if allPallettes?.isEmpty ?? true {
            if allPallettes == nil {
                assertionFailure("🛑 ERROR: Unable to fetch pallette from CoreData")
            }
            print("⚠️ NO EXISTING PALLETTE -- CREATING NEW ONE")
            context.insert(firstPallette)
            try? context.save()
        }
        self._pallette = firstPallette
    }
    
    func color(for id: UUID) -> Color? {
        _pallette.pallette.first(where: { $0.id == id })?.color
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<_UserColorPallette, T>) -> T {
        get {
            _pallette[keyPath: keyPath]
        }
        set {
            _pallette[keyPath: keyPath] = newValue
            try? Self.context.save()
        }
    }
}

// MARK: @Model Object

/// Do not reference this object direclty.
/// Instead, reference `ColorPallette.current` instead.
@Model
final class _UserColorPallette {
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
    
    func color(for id: UUID) -> Color? {
        pallette.first(where: { $0.id == id })?.color
    }
}

// MARK: - ColorOption

struct ColorOption: Identifiable, Codable {
    private(set) var id = UUID()
    var hex: String // `var` == allow changing color value
    var color: Color { Color(hex: hex) }
    
    init(color: Color) {
        guard let hex = color.toHex() else {
            assertionFailure("Unable to initialize ColorOption from Color - unable to get hex")
            self.hex = "#000000"
            return
        }
        self.hex = hex
    }
}

