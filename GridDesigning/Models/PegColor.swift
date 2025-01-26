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


import SwiftData

@Model
final class PegColor {
    var hex: String
    private(set) var id: UUID

    init(hex: String, id: UUID) {
        self.hex = hex
        self.id = id
    }
}
