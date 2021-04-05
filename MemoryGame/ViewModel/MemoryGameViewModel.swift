//
//  MemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Gabriel Lucas Santos on 04/04/21.
//

import Foundation

enum Themes {
    case FACE
    case FOOD
    case ANIMAL
}

class MemoryGameViewModel: ObservableObject {
    
    @Published
    var model: MemoryGameModel<String>
    var emojis: [String]
    
    init(theme: Themes) {
        self.emojis = MemoryGameViewModel.pickEmojis(theme: theme)
        model = MemoryGameViewModel.initGame(emojis: emojis)
        
    }
 
    static func initGame(emojis: [String]) -> MemoryGameModel<String> {
        let emojis = emojis.dropLast(emojis.count - Int.random(in: 2...5))
        return MemoryGameModel<String>(numberPairsCards: emojis.count) {
            emojis[$0]
        }
    }
    
    var cards: Array<MemoryGameModel<String>.Card> {
        model.cards
    }
    
    var numberPairs: Int {
        Int(model.cards.count / 2)
    }
    
    var score: Int {
        model.score
    }
    
    func pick(card : MemoryGameModel<String>.Card) {
        model.pick(card: card)
    }
    
    func newGame() {
        model = MemoryGameViewModel.initGame(emojis: emojis)
    }
    
    static func pickEmojis (theme: Themes) -> [String] {
        switch theme {
            case .FACE:
                return ["😀", "😄", "🥲", "🥰", "😛", "😎"].shuffled()
            case .ANIMAL:
                return ["🐸", "🐣", "🦕", "🐱", "🦄", "🐍"].shuffled()
            case .FOOD:
                return ["🍕", "🍉", "🌭", "🍇", "🍔", "🍌"].shuffled()
            }
    }
        
}
