//
//  PegboardDrawingView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import SwiftUI

struct PegboardDrawingView: View {
    @State var currentColorID: UUID?
    @State var sharableSnapshot: UIImage?
    let pegboard: Pegboard
    @State var pegboardSizing = PegboardViewSize()
    
    var body: some View {
        VStack {
            AllScrollView {
                PegboardView(pegboard: pegboard, currentColorID: $currentColorID, pallette: UserPallette.current.pallette, size: $pegboardSizing)
            }
            ScrollView(.horizontal) {
                HorizontalColorPicker(pegboard: pegboard, currentColorID: $currentColorID)
            }
        }
        .onAppear {
            currentColorID = pegboard.designPallette.first
        }
        .background(Color.black)
        .toolbar {
            if let sharableSnapshot {
                ToolbarItem(placement: .topBarLeading) {
                    ShareLink(item: sharableSnapshot, preview: SharePreview("Pegboard", image: sharableSnapshot))
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    sharableSnapshot = ImageRenderer(content: printableView).uiImage
                } label: {
                    Image(systemName: "camera")
                }
            }
        }
    }
        
    @ViewBuilder
    var printableView: some View {
        PegboardPrintableView(pegboard: pegboard, size: .printing)
    }
    
    
}

#Preview {
    RootView()
}

extension UIImage: @retroactive Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: { Image(uiImage: $0) })
    }
}
//struct Photo: Transferable {
//    static var transferRepresentation: some TransferRepresentation {
//        ProxyRepresentation(exporting: \.image)
//    }
//
//
//    public var image: Image
//    public var caption: String
//}
