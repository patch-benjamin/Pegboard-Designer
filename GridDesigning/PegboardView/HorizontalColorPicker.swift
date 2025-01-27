//
//  HorizontalColorPicker.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI

struct HorizontalColorPicker: View {
    @Environment(\.modelContext) private var modelContext
    private let userPallette = UserPallette.current
    var pegboard: Pegboard
    @Binding var currentColorID: UUID?
    var buttonDiameter: CGFloat = 80
    var hideAddButton = false
    
    var body: some View {
        HStack {
            ForEach(pegboard.designPallette, id: \.self) { colorID in
                if let color = userPallette.color(for: colorID) {
                    color
                        .circularButtonStyle(diameter: buttonDiameter, onTap: {
                            currentColorID = colorID
                        })
                        .border(currentColorID == colorID ? Color.white : .clear, width: 5)
                } else {
                    invalidColorButton
                }
            }
            if !hideAddButton {
                addColorsButton
            }
        }
    }
    
    @ViewBuilder
    var invalidColorButton: some View {
        Image(systemName: "questionmark")
            .foregroundStyle(Color.black)
            .background(Color.white)
            .circularButtonStyle(diameter: buttonDiameter) {
                // present user color pallette
            }
    }
    
    @ViewBuilder
    var addColorsButton: some View {
        NavigationLink {
            UserColorPalletteView(selectedColors: .init(get: {
                pegboard.designPallette
            }, set: { newIDs in
                pegboard.designPallette = newIDs
                try? modelContext.save()
            }))
        } label: {
            ZStack {
                Color.white
                Image(systemName: "plus")
                    .imageScale(.large)
                    .foregroundStyle(Color.black)
            }
            .circularButtonStyle(diameter: buttonDiameter * 0.6)
        }
    }
}

#Preview {
//    HorizontalColorPicker()
}

