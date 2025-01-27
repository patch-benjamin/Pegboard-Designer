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

    var body: some View {
        VStack {
            AllScrollView {
                pegboardView
            }
            ScrollView(.horizontal) {
                HorizontalColorPicker(pegboard: pegboard, currentColorID: $currentColorID)
            }
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
                    sharableSnapshot = ImageRenderer(content: pegboardView).uiImage
                } label: {
                    Image(systemName: "camera")
                }
            }
        }
    }
    
    @ViewBuilder
    var pegboardView: some View {
        PegboardView(pegboard: pegboard, currentColorID: $currentColorID, pallette: UserPallette.current.pallette)
    }
    
    
}

#Preview {
    RootView()
}

//struct HorizontalColorPallet: View {
//    static let buttonSize: CGFloat = 60
//    @State var colors: [Color] = []
//    
//    var body: some View {
//        ScrollView(.horizontal) {
//            HStack {
//                ForEach($colors, id: \.self) { color in
//                    colorButton(color)
//                }
//                addColorButton
//            }
//        }
//        .padding(.vertical)
//    }
//    
//    @ViewBuilder
//    func colorButton(_ color: Binding<Color>) -> some View {
//        let index = colors.firstIndex(of: color.wrappedValue) ?? -1
//        ColorPicker("\(index)", selection: color, supportsOpacity: false)
//            .foregroundStyle(Color.white)
//    }
//    var addColorButton: some View {
//        Button {
//            colors.append(.white)
//        } label: {
//            Group {
//                Color.white
//                    .cornerRadius(Self.buttonSize / 2)
//                Image(systemName: "plus")
//                    .foregroundStyle(.black)
//                    .font(.largeTitle)
//                    .frame(width: Self.buttonSize, height: Self.buttonSize)
//            }
//            .frame(width: Self.buttonSize, height: Self.buttonSize)
//        }
//    }
//}
//
//

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
