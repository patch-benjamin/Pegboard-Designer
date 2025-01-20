//
//  ZoomableView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import SwiftUI

struct ZoomableView<ContentView: View>: View {
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0

    @ViewBuilder
    var content: () -> ContentView
    
    var body: some View {
        content()
            .scaleEffect(currentZoom + totalZoom)
            .gesture(
                MagnifyGesture()
                    .onChanged { value in
                        currentZoom = value.magnification - 1
                    }
                    .onEnded { value in
                        totalZoom += currentZoom
                        currentZoom = 0
                    }
            )
            .accessibilityZoomAction { action in
                if action.direction == .zoomIn {
                    totalZoom += 1
                } else {
                    totalZoom -= 1
                }
            }
    }
}
#Preview {
    ZoomableView {
        Image(systemName: "star")
    }
}
