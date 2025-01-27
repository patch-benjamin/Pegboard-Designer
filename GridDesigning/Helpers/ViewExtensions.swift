//
//  ViewExtensions.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI

extension View {
    static var circularButtonSize: CGFloat { 80 }

    func circularButtonStyle(onTap: @escaping () -> Void) -> some View {
        self
        .frame(width: Self.circularButtonSize, height: Self.circularButtonSize)
        .cornerRadius(Self.circularButtonSize / 2)
        .onTapGesture(perform: onTap)

    }
    
    func circularButtonStyle() -> some View {
        self
        .frame(width: Self.circularButtonSize, height: Self.circularButtonSize)
        .cornerRadius(Self.circularButtonSize / 2)
    }
}
