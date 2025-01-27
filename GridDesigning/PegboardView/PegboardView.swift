//
//  PegboardView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import SwiftUI

@Observable class PegboardViewSize {
    var pegSize: CGFloat
    var dividerWidth: CGFloat
    var borderWidth: CGFloat
    var isThumbnail: Bool
    
    static var thumbnail: PegboardViewSize {
        .init(pegSize: 4, dividerWidth: 1, borderWidth: 2, isThumbnail: true)
    }
    
    static var printing: PegboardViewSize {
        .init(borderWidth: 16)
    }
    
    convenience init(pegSize: CGFloat = 41.6, dividerWidth: CGFloat = 8, borderWidth: CGFloat = 0) {
        self.init(pegSize: pegSize, dividerWidth: dividerWidth, borderWidth: borderWidth, isThumbnail: false)
    }
    
    private init(pegSize: CGFloat, dividerWidth: CGFloat, borderWidth: CGFloat, isThumbnail: Bool) {
        self.pegSize = pegSize
        self.dividerWidth = dividerWidth
        self.borderWidth = borderWidth
        self.isThumbnail = isThumbnail
    }
}

struct PegboardView: View {
    let pegboard: Pegboard
    @Binding var currentColorID: UUID?
    let pallette: [ColorOption]
    let rowIndexes: [Int] // [0,1,2,3,etc]
    let pegIndexes: [Int] // [0,1,2,3,etc]
    @Binding var size: PegboardViewSize
    var buttonSize: CGFloat { size.pegSize }
    var barWidth: CGFloat { size.dividerWidth }
    var isThumbnail: Bool { size.isThumbnail }

    init(pegboard: Pegboard, currentColorID: Binding<UUID?>, pallette: [ColorOption], size: Binding<PegboardViewSize>) {
        self.pegboard = pegboard
        self._currentColorID = currentColorID
        self.pallette = pallette
        self._size = size
        rowIndexes = .init(0..<pegboard.rows.count)
        if let rowCount = pegboard.rows.first?.count {
            pegIndexes = .init(0..<rowCount)
        } else {
            pegIndexes = []
        }
    }
 
    var body: some View {
        Grid(horizontalSpacing: barWidth, verticalSpacing: barWidth) {
            if !isThumbnail {
                topRow
            }
            ForEach(rowIndexes, id: \.self) { rowIndex in
                GridRow {
                    if !isThumbnail {
                        Text(Self.alphabet[rowIndex])
                    }
                    ForEach(pegIndexes, id: \.self) { pegIndex in
                        VStack(spacing: barWidth) {
                            coloredButton(rowIndex: rowIndex, pegIndex: pegIndex)
                        }
                    }
                }
            }
        }
        .padding(size.borderWidth)
        .padding(.bottom, isThumbnail ? 0 : 8)
        .scrollIndicators(.visible)
        .foregroundStyle(Color.white)
        .background(Color.black)
    }
    
    @ViewBuilder
    func coloredButton(rowIndex: Int, pegIndex: Int) -> some View {
        let pegHole = pegboard.rows[rowIndex][pegIndex]
        color(for: pegHole)
            .frame(width: buttonSize, height: buttonSize)
            .onTapGesture {
                setColor(rowIndex: rowIndex, pegIndex: pegIndex)
            }
    }
    
    @ViewBuilder
    func color(for pegHole: PegHole) -> some View {
        if let colorOption = pallette.first(where: { $0.id == pegHole.colorID }) {
            colorOption.color
        } else {
            Color.white
        }
    }
    
    @ViewBuilder
    var topRow: some View {
        GridRow {
            Spacer()
            ForEach(pegIndexes, id: \.self) { column in
                Text("\(column)")
            }
        }
    }
    
    func setColor(rowIndex: Int, pegIndex: Int) {
        let newColorID: UUID?
        let pegHole = pegboard.rows[rowIndex][pegIndex]
        let currentColorOption = pallette.first(where: { $0.id == currentColorID })
        
        if pegHole.colorID == currentColorOption?.id {
            newColorID = nil
        } else {
            newColorID = currentColorOption?.id
        }
        pegboard.rows[rowIndex][pegIndex].colorID = newColorID
    }

}

extension PegboardView {
    static let alphabet = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,AA,BB,CC,DD,EE,FF,GG,HH,II,JJ,KK,LL,MM,NN,OO,PP,QQ,RR,SS,TT,UU,VV,WW,XX,YY,ZZ,AAA,BBB,CCC,DDD,EEE,FFF,GGG,HHH,III,JJJ,KKK,LLL,MMM,NNN,OOO,PPP,QQQ,RRR,SSS,TTT,UUU,VVV,WWW,XXX,YYY,ZZZ".split(separator: ",").map { String($0) }
}

#Preview {
//    PegboardDrawingView(columns: 16, rows: 16)
}
