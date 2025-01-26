//
//  PegboardDrawingView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import SwiftUI

struct PegboardDrawingView: View {
    @State var currentColor: Color = .black
    @State var sharableSnapshot: UIImage?
    let columns: Int
    let rows: Int
    
    // [Column: [Row: COLOR]]
    @State var buttonColors: [Int: [Int: Color]] = [:]
    @State var colorPallette: [Color] = []

    var body: some View {
        VStack {
            AllScrollView {
                pegboard
            }
            ScrollView(.horizontal) {
                horizontalColorPicker
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
                    sharableSnapshot = ImageRenderer(content: pegboard).uiImage
                } label: {
                    Image(systemName: "camera")
                }
            }
            
        }
    }
    
    @ViewBuilder
    var pegboard: some View {
        Text("")
//        (columns: columns, rows: rows, currentColor: $currentColor, buttonColors: $buttonColors, colorPallette: $colorPallette)
    }
    
    @ViewBuilder
    var horizontalColorPicker: some View {
        let buttonSize: CGFloat = 80
        HStack {
            colorPicker
            ForEach(colorPallette, id: \.self) { color in
                color
                    .frame(width: buttonSize, height: buttonSize)
                    .cornerRadius(buttonSize / 2)
                    .onTapGesture {
                        currentColor = color
                    }
                    .onLongPressGesture {
                        guard currentColor != color else { return }
                        replaceAllColors(color, with: currentColor)
                        updateColorPallette(replace: color, with: currentColor)
                    }
            }
        }
    }

    var colorPicker: some View {
        ColorPicker("", selection: $currentColor, supportsOpacity: false)
            .labelsHidden()
            .scaleEffect(CGSize(width: 3, height: 3))
            .padding(30)
    }
    
    func replaceAllColors(_ color: Color, with newColor: Color) {
        for key in buttonColors.keys {
            guard let rowKeys = buttonColors[key]?.keys else { continue }
            for rowKey in rowKeys {
                if buttonColors[key]?[rowKey] == color {
                    buttonColors[key]?[rowKey] = newColor
                }
            }
        }
    }
    
    func updateColorPallette(replace color: Color, with newColor: Color) {
        guard let colorIndex = colorPallette.firstIndex(where: { $0 == color }) else { return }
        colorPallette.removeAll(where: { $0 == newColor })
        colorPallette[colorIndex] = newColor
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
