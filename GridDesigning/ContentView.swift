//
//  ContentView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationStack {
            PegboardDrawingView(columns: 16, rows: 16)
        }
    }
}



#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}

//@Model
//class RGBColor {
//    private var red: CGFloat
//    private var green: CGFloat
//    private var blue: CGFloat
//    var color: Color { .init(uiColor: .init(red: red, green: green, blue: blue, alpha: 1)) }
//    init(color: Color) {
//        let ciColor = CIColor(color: UIColor(color))
//        red = ciColor.red
//        green = ciColor.green
//        blue = ciColor.blue
//    }
//}
//
//struct Peg {
//    private var rgb: RGBColor
//    var color: Color {
//        get { rgb.color }
//        set { rgb = .init(color: newValue) }
//    }
//}
//
//struct Pegboard {
//    private var pegs: [[Color]]
//}
