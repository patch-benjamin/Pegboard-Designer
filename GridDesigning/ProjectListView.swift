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
    @Query private var pegboards: [Pegboard]
    
    var body: some View {
        List(pegboards) { pegboard in
            NavigationLink {
                PegboardDrawingView(pegboard: pegboard)
            } label: {
                PegboardView(pegboard: pegboard, currentColor: .constant(.white), pallette: UserPallette.current.pallette, isThumbnail: true)
                    .fixedSize()
                    .clipped()
            }
        }
    }
}

#Preview {
    ProjectListView()
}
