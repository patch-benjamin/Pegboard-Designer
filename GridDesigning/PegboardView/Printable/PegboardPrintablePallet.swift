//
//  PegboardPrintablePallet.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI

struct PegboardPrintablePallet: View {
    var colors: [(Color, Int)]
    let size: PegboardViewSize
    
    init(pegboard: Pegboard, size: PegboardViewSize) {
        var colors: [Color: Int] = [:]
        for peg in pegboard.rows.flatMap({ $0 }) {
            guard let colorID = peg.colorID else { continue }
            let color = UserPallette.current.color(for: colorID) ?? .black
            colors[color, default: 0] += 1
        }
        self.colors = colors.sorted { $0.value > $1.value }
        self.size = size
    }
    
    var body: some View {
        Grid(verticalSpacing: size.dividerWidth + 2) {
            GridRow {
                HStack {
                    Text("Color")
                    Text("Count")
                }
                .foregroundStyle(Color.white)
            }
            ForEach(colors, id: \.0) { (color, count) in
                GridRow {
                    HStack(spacing: size.dividerWidth) {
                        color
                            .frame(width: size.pegSize, height: size.pegSize)
                        ZStack {
                            Color.white
                            Text(verbatim: "\(count)")
                                .foregroundStyle(Color.black)
                        }
                        .frame(width: size.pegSize, height: size.pegSize)
                    }
                }
            }
        }
        .padding(size.borderWidth)
    }
}
