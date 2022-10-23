//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by hoang on 08/10/2022.
//

import Foundation

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    private var indexOfFaceUpCard: Int? {
        get { cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    private(set) var score: Int
        
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        score = 0
        
        // add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
                !cards[chosenIndex].isFaceUp,
                !cards[chosenIndex].isMatched {
            if let faceUpCardIndex = indexOfFaceUpCard { // a card is already face up i.e. chosen previously
                if cards[chosenIndex].content == cards[faceUpCardIndex].content { // a match
                    cards[chosenIndex].isMatched = true
                    cards[faceUpCardIndex].isMatched = true
                    score += 2
                } else { // a mismatch
                    if cards[chosenIndex].hasSeen {
                        score -= 1
                    }
                    if cards[faceUpCardIndex].hasSeen {
                        score -= 1
                    }
                }
                cards[chosenIndex].hasSeen = true
                cards[faceUpCardIndex].hasSeen = true
                cards[chosenIndex].isFaceUp = true
            } else { // no face-up card
                indexOfFaceUpCard = chosenIndex
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var hasSeen = false
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
