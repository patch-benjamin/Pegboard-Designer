//
//  ProjectListView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var projects: [Pegboard]
    var body: some View {
        List(projects) { project in
            
        }
        Text("t")
    }
}

#Preview {
    ProjectListView()
}
