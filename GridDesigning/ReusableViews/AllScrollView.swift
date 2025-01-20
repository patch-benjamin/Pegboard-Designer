//
//  AllScrollView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import SwiftUI

struct AllScrollView<Content: View>: View {
    let content: () -> Content
    var body: some View {
        ScrollView(.horizontal) {
            ScrollView(.vertical) {
                content()
            }
        }
    }
}

#Preview {
    AllScrollView {
        Color.blue
            .border(Color.red, width: 5)
            .frame(width: 1600, height: 1600)
    }
}
