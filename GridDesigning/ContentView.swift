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
        PegboardView(columns: 16, rows: 16)
    }
}



#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
