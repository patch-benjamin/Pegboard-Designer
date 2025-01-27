//
//  ColorPickerWrapper.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI

struct ColorPickerWrapper: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedColor: Color = .white // Default color
    var didSelectColor: (Color) -> Void
    
    var body: some View {
        VStack {
            ColorPicker("Pick a Color", selection: $selectedColor, supportsOpacity: true)
                .onChange(of: selectedColor) { _, newColor in
                    didSelectColor(newColor)
                    dismiss()
                }
                .padding()
        }
    }
}
