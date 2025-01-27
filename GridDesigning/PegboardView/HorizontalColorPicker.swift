//
//  HorizontalColorPicker.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI

struct HorizontalColorPicker: View {
    private let userPallette = UserPallette.current
    var pegboard: Pegboard
    var pegboardPalletteColorIDs: [UUID] { pegboard.designPallette }
    @Binding var currentColor: Color
    
    var body: some View {
        HStack {
            ForEach(pegboardPalletteColorIDs, id: \.self) { colorID in
                if let color = userPallette.color(for: colorID) {
                    color.circularButtonStyle(onTap: {
                        currentColor = color
                    })
                } else {
                    invalidColorButton
                }
            }
            addColorsButton
        }
    }
    
    @ViewBuilder
    var invalidColorButton: some View {
        Image(systemName: "questionmark")
            .foregroundStyle(Color.black)
            .background(Color.white)
            .circularButtonStyle {
                // present user color pallette
            }
    }
    
    @ViewBuilder
    var addColorsButton: some View {
        NavigationLink {
            UserColorPalletteView(selectedColors: .init(get: {
                pegboard.designPallette
            }, set: { newIDs in
                pegboard.addColorIDsToPallette(newIDs)
            }))
        } label: {
            Image(systemName: "plus")
                .circularButtonStyle()
        }
    }
}

#Preview {
//    HorizontalColorPicker()
}

