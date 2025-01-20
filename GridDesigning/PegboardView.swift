//
//  PegboardView.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import SwiftUI

struct PegboardView: View {
    let columns: [Int]
    let rows: [Int]

    @State var currentColor: Color = .blue
    @State var buttonColors: [Int: [Int: Color]] = [:] // [Column: [Row: COLOR]]

    init(columns: Int, rows: Int) {
        self.columns = Array<Int>(0..<columns)
        self.rows = Array<Int>(0..<rows)
    }
 
    var body: some View {
        AllScrollView {
            Grid(horizontalSpacing: Self.barWidth, verticalSpacing: Self.barWidth) {
                topRow
                ForEach(rows, id: \.self) { row in
                    GridRow {
                        Text(Self.alphabet[row])
                        ForEach(columns, id: \.self) { column in
                            VStack(spacing: Self.barWidth) {
                                coloredButton(column: column, row: row)
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.visible)
            .foregroundStyle(Color.white)
        }
        .background(Color.black)
    }
    
    @ViewBuilder
    func coloredButton(column: Int, row: Int) -> some View {
        Button() {
            setColor(column: column, row: row)
        } label: {
            buttonColors[column]?[row] ?? .white
        }
        .frame(width: Self.buttonSize, height: Self.buttonSize)
    }
    
    @ViewBuilder
    var topRow: some View {
        GridRow {
            Spacer()
            ForEach(columns, id: \.self) { column in
                Text("\(column)")
            }
        }
    }
    
    func setColor(column: Int, row: Int) {
        let newColor: Color?
        if let color = buttonColors[column]?[row], color == currentColor {
            newColor = nil
        } else {
            newColor = currentColor
        }
        buttonColors[column, default: [:]][row] = newColor
    }

}

private extension PegboardView {
    static let buttonSize: CGFloat = 40
    static let barWidth: CGFloat = 8
    static let alphabet = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,AA,BB,CC,DD,EE,FF,GG,HH,II,JJ,KK,LL,MM,NN,OO,PP,QQ,RR,SS,TT,UU,VV,WW,XX,YY,ZZ,AAA,BBB,CCC,DDD,EEE,FFF,GGG,HHH,III,JJJ,KKK,LLL,MMM,NNN,OOO,PPP,QQQ,RRR,SSS,TTT,UUU,VVV,WWW,XXX,YYY,ZZZ".split(separator: ",").map { String($0) }
}

#Preview {
    PegboardView(columns: 16, rows: 16)
}
