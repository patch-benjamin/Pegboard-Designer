//
//  UserColorPalletteView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI

struct UserColorPalletteView: View {
    @State var userPallette = UserPallette.current
    @Binding var selectedColors: [UUID]
    @State private var presentColorPicker = false
    
    var body: some View {
        List {
            ForEach(userPallette.pallette) { colorOption in
                HStack {
                    colorOption.color
                        .circularButtonStyle {
                            selectedColors.append(colorOption.id)
                        }
                    Spacer()
                    
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    userPallette.pallette.remove(at: index)
                }
            }
            Button {
                presentColorPicker = true
            } label: {
                HStack {
                    Text("Add Color to User Pallette")
                    Image(systemName: "plus")
                    Spacer()
                }
            }
            .sheet(isPresented: $presentColorPicker) {
                ColorPickerWrapper { newColor in
                    userPallette.pallette.append(.init(color: newColor))
                }
            }
        }
    }
    
    @ViewBuilder
    func colorRow(for colorOption: ColorOption) -> some View {
        let colorBinding = Binding<Color>.init {
            colorOption.color
        } set: { newColor in
            guard let index = userPallette.pallette.firstIndex(where: { $0.id == colorOption.id }), let hex = newColor.toHex() else { return }
            userPallette.pallette[index].hex = hex
        }

        ColorPicker("", selection: colorBinding, supportsOpacity: false)
            .labelsHidden()
            .scaleEffect(CGSize(width: 3, height: 3))
            .padding(30)
    }
}

