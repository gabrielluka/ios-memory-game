//
//  CardModifier.swift
//  MemoryGame
//
//  Created by Gabriel Lucas Santos on 04/04/21.
//

import SwiftUI

struct CardModifier: ViewModifier {
    
    private var rotation: Double
    
    init(isFacingUp: Bool) {
        rotation = isFacingUp ? 0 : 180
    }
    
    var isFacingUp: Bool {
        rotation < 90
    }
    
    // MARK: - Constantes de Desenho
    private let cornerRadius: CGFloat = 12
    private let lineWidth: CGFloat = 4
    
    
    func body(content: Content) -> some View {
        ZStack {
            if  isFacingUp {
                turnUp()
                content
            } else {
                turnDown()
            }
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    @ViewBuilder
    func turnUp() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
    }
    
    @ViewBuilder
    func turnDown() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius).fill()
    }
    
}

extension View {
    
    func turnCard(isFacingUp: Bool) -> some View {
        self.modifier(CardModifier(isFacingUp: isFacingUp))
    }
    
}
