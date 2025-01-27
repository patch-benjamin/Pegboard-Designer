//
//  ViewExtensions.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI

extension View {
    func circularButtonStyle(diameter: CGFloat = 80, onTap: @escaping () -> Void) -> some View {
        self
        .frame(width: diameter, height: diameter)
        .cornerRadius(diameter / 2)
        .onTapGesture(perform: onTap)

    }
    
    func circularButtonStyle(diameter: CGFloat = 80) -> some View {
        self
        .frame(width: diameter, height: diameter)
        .cornerRadius(diameter / 2)
    }
}
