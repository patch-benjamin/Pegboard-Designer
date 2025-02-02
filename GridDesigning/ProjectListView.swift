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
        List {
            ForEach(pegboards) { pegboard in
                NavigationLink {
                    PegboardDrawingView(pegboard: pegboard)
                } label: {
                    HStack(alignment: .top) {
                        PegboardView(pegboard: pegboard, currentColorID: .constant(nil), pallette: UserPallette.current.pallette, size: .constant(.thumbnail))
                            .fixedSize()
                            .clipped()
                        HorizontalColorPicker(pegboard: pegboard, currentColorID: .constant(nil), buttonDiameter: 16, hideAddButton: true)
                    }
                }
            }
            .onDelete { indexSet in
                var pegboards = [Pegboard]()
                for index in indexSet {
                    pegboards.append(self.pegboards[index])
                }
                for pegboard in pegboards {
                    self.modelContext.delete(pegboard)
                    try? self.modelContext.save()
                }
            }
        }
    }
}

#Preview {
    ProjectListView()
}
