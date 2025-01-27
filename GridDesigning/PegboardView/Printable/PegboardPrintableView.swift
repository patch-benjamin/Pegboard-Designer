//
//  PegboardPrintableView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/26/25.
//

import SwiftUI

struct PegboardPrintableView: View {
    let pegboard: Pegboard
    var size: PegboardViewSize

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            pegboardView
                .padding(size.borderWidth)
                .background(Color.black)
            PegboardPrintablePallet(pegboard: pegboard, size: size)
                .padding(size.borderWidth)
                .background(Color.black)
                .padding(.leading, size.dividerWidth)
        }
    }

    @ViewBuilder
    var pegboardView: some View {
        PegboardView(pegboard: pegboard, currentColorID: .constant(nil), pallette: UserPallette.current.pallette, size: .constant(size))
    }

}
