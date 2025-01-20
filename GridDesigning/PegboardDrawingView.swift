//
//  PegboardDrawingView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import SwiftUI

struct PegboardDrawingView: View {
    @State var currentColor: Color = .black
    let columns: Int
    let rows: Int
    
    var body: some View {
        ZStack {
            AllScrollView {
                PegboardView(columns: columns, rows: rows, currentColor: $currentColor)
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ColorPicker("", selection: $currentColor, supportsOpacity: false)
                        .labelsHidden()
                        .scaleEffect(CGSize(width: 3, height: 3))
                    Spacer()
                }
            }
        }
        .background(Color.black)
    }
}

#Preview {
    PegboardDrawingView(columns: 16, rows: 16)
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
