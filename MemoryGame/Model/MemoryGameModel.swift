//
//  MemoryGameModel.swift
//  MemoryGame
//
//  Created by Gabriel Lucas Santos on 04/04/21.
//

import Foundation


struct MemoryGameModel<ContentCard> where ContentCard: Equatable{
    var cards: [Card]
    var score: Int = 0
    
    private var indexOnlyCardFacingUp: Int?
    
    private var indexCardChosen: Int? {
        get {
            cards.indices.filter { cards[$0].isFacingUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFacingUp = index == newValue
            }
        }
    }
    
    init(numberPairsCards: Int, buildingCards: (Int) -> ContentCard) {
        cards = Array<Card>()
        for index in 0..<numberPairsCards {
            let content = buildingCards(index)
            cards.append(Card(id: index * 2, content: content))
            cards.append(Card(id: index * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    mutating func pick(card: Card) {
        if let indexCardSelected = cards.firstIndex(matching: card) {
            if let possibleCombination = indexCardChosen {
                if cards[indexCardSelected].content == cards[possibleCombination].content {
                    cards[indexCardSelected].isMatching = true
                    cards[possibleCombination].isMatching = true
                    calculationScore(card: cards[possibleCombination])
                }
                cards[indexCardSelected].isFacingUp = true
            } else {
                indexCardChosen = indexCardSelected
            }
        }
    }
    
    mutating func calculationScore(card: Card) {
        if (card.remainingBonus > 0.50) {
            score += 5
        } else {
            score += 3
        }
    }
    
    
    struct Card: Identifiable {
        var id: Int
        var isFacingUp = false {
            didSet {
                if isFacingUp {
                    startedUseBonusTime()
                } else {
                    stopUseBonusTime()
                }
            }
        }
        
        var isMatching = false {
            didSet {
                stopUseBonusTime()
            }
        }
        
        var content: ContentCard
        var bonusTime: TimeInterval = 6
        var lastTimeTurnedUp: Date?
        var lastTimeWasFacingUp: TimeInterval = 0
        
        private var turnUpTime: TimeInterval {
            if let lastTurning = self.lastTimeTurnedUp {
                return lastTimeWasFacingUp + Date().timeIntervalSince(lastTurning)
            } else {
                return lastTimeWasFacingUp
            }
        }
        
        var remainingBonus: Double {
            (bonusTime > 0 && timeBonusRemaining > 0) ? timeBonusRemaining / bonusTime : 0
        }
        
        var timeBonusRemaining: TimeInterval {
            max(0, bonusTime -  turnUpTime)
        }
        
        var consumingBonusTime: Bool {
            isFacingUp && !isMatching && timeBonusRemaining > 0
        }
        
        private mutating func startedUseBonusTime () {
            if consumingBonusTime, lastTimeTurnedUp == nil {
                lastTimeTurnedUp = Date()
            }
        }
        
        private mutating func stopUseBonusTime() {
            lastTimeWasFacingUp = turnUpTime
            lastTimeTurnedUp = nil
        }
    }
}
