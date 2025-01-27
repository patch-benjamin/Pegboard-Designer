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
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(selectedColors, id: \.self) { colorID in
                        userPallette.color(for: colorID)?
                            .circularButtonStyle(diameter: 40)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            List {
                Section {
                    ForEach(userPallette.pallette) { colorOption in
                        Button {
                            if selectedColors.contains(colorOption.id) {
                                selectedColors.removeAll(where: { $0 == colorOption.id })
                            } else {
                                selectedColors.append(colorOption.id)
                            }
                        } label: {
                            HStack {
                                colorOption.color
                                    .circularButtonStyle()
                                Spacer()
                                Image(systemName: selectedColors.contains(colorOption.id) ? "checkmark.square.fill" : "square")
                                    .foregroundStyle(selectedColors.contains(colorOption.id) ? Color.green : Color.black)
                            }
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
                }
                .sheet(isPresented: $presentColorPicker) {
                    ColorPickerWrapper { newColor in
                        userPallette.pallette.append(.init(color: newColor))
                    }
                }
                if userPallette.pallette.count > 5 {
                    Section {
                        Button {
                            userPallette.pallette.removeAll()
                        } label: {
                            HStack {
                                Text("Delete ALL Colors")
                                Image(systemName: "trash")
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .listRowBackground(Color.red)
                    .foregroundStyle(Color.white)
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

