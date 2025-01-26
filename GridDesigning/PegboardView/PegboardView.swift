//
//  PegboardView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import SwiftUI

struct PegboardView: View {
    let pegboard: Pegboard
    @Binding var currentColor: Color
    let pallette: [ColorOption]
    let rowIndexes: [Int] // [0,1,2,3,etc]
    let pegIndexes: [Int] // [0,1,2,3,etc]

    init(pegboard: Pegboard, currentColor: Binding<Color>, pallette: [ColorOption]) {
        self.pegboard = pegboard
        self._currentColor = currentColor
        self.pallette = pallette
        rowIndexes = .init(0..<pegboard.rows.count)
        if let rowCount = pegboard.rows.first?.count {
            pegIndexes = .init(0..<rowCount)
        } else {
            pegIndexes = []
        }
    }
 
    var body: some View {
        Grid(horizontalSpacing: Self.barWidth, verticalSpacing: Self.barWidth) {
            topRow
            ForEach(rowIndexes, id: \.self) { rowIndex in
                GridRow {
                    Text(Self.alphabet[rowIndex])
                    ForEach(pegIndexes, id: \.self) { pegIndex in
                        VStack(spacing: Self.barWidth) {
                            coloredButton(rowIndex: rowIndex, pegIndex: pegIndex)
                        }
                    }
                }
            }
        }
        .padding(.bottom)
        .scrollIndicators(.visible)
        .foregroundStyle(Color.white)
    }
    
    @ViewBuilder
    func coloredButton(rowIndex: Int, pegIndex: Int) -> some View {
        let pegHole = pegboard.rows[rowIndex][pegIndex]
        color(for: pegHole)
            .frame(width: Self.buttonSize, height: Self.buttonSize)
            .onTapGesture {
                setColor(rowIndex: rowIndex, pegIndex: pegIndex)
            }
    }
    
    @ViewBuilder
    func color(for pegHole: PegHole) -> some View {
        if let colorOption = pallette.first(where: { $0.id == pegHole.colorID }) {
            colorOption.color
        } else {
            Image(systemName: "questionmark")
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
        let currentColorOption = pallette.first(where: { $0.hex == currentColor.toHex() })
        
        if pegHole.colorID == currentColorOption?.id {
            newColorID = nil
        } else {
            newColorID = currentColorOption?.id
        }
        pegboard.rows[rowIndex][pegIndex].colorID = newColorID
    }

}

extension PegboardView {
    static let buttonSize: CGFloat = 41.6
    static let barWidth: CGFloat = 8
    static let alphabet = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,AA,BB,CC,DD,EE,FF,GG,HH,II,JJ,KK,LL,MM,NN,OO,PP,QQ,RR,SS,TT,UU,VV,WW,XX,YY,ZZ,AAA,BBB,CCC,DDD,EEE,FFF,GGG,HHH,III,JJJ,KKK,LLL,MMM,NNN,OOO,PPP,QQQ,RRR,SSS,TTT,UUU,VVV,WWW,XXX,YYY,ZZZ".split(separator: ",").map { String($0) }
}

#Preview {
    PegboardDrawingView(columns: 16, rows: 16)
}
