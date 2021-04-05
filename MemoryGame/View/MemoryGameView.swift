//
//  MemoryGameView.swift
//  MemoryGame
//
//  Created by Gabriel Lucas Santos on 04/04/21.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject
    var viewModel: MemoryGameViewModel
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        withAnimation(.linear) {
                            viewModel.pick(card: card)
                        }
                    }
                    .padding(4)
            }
            HStack {
                Button("New Game") {
                    withAnimation(.easeInOut) {
                        viewModel.newGame()
                    }
                }
                Text("Score : \(viewModel.score)").font(.title2).fixedSize()
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration:1.0)))
            }
          
        }
        
        .padding()
        .foregroundColor(Color.purple)
    }
}

struct CardView: View {
    var card: MemoryGameModel<String>.Card
    
    @State
    private var tempoRestanteBonus: Double = 0
    
    private func comecarAnimacaoCronometro() {
        tempoRestanteBonus = card.remainingBonus
        withAnimation(.linear(duration: card.timeBonusRemaining)) {
            tempoRestanteBonus = 0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFacingUp || !card.isMatching {
                ZStack {
                    Group {
                        if card.consumingBonusTime {
                            Cronometro(anguloInicial: Angle.degrees(0-90),
                                       anguloFinal: Angle.degrees(-tempoRestanteBonus * 360 - 90),
                                       sentidoHorario: true)
                            .onAppear {
                                comecarAnimacaoCronometro()
                            }
                        }else {
                            Cronometro(anguloInicial: Angle.degrees(0-90),
                                       anguloFinal: Angle.degrees(-card.remainingBonus * 360 - 90),
                                       sentidoHorario: true)
                        }
                    }
                    .opacity(0.5)
                    .padding(4)
                    
                    Text(card.content)
                        .font(Font.system(size: fontSize(size: geometry.size)))
                        .rotationEffect(Angle.degrees(card.isMatching ? 360 : 0))
                        .animation(card.isMatching ? Animation.linear(duration: 3).repeatForever(autoreverses: false) : .default)
                }
                .turnCard(isFacingUp: card.isFacingUp)
                .transition(.scale)
            }
        }
    }

    private func fontSize(size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.7
    }
}
