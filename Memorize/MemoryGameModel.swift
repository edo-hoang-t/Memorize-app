//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by hoang on 08/10/2022.
//

import Foundation

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    private var indexOfFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
//        card.isFaceUp = !card.isFaceUp // cannot do this since 'card' argument is constant and copied
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
                !cards[chosenIndex].isFaceUp,
                !cards[chosenIndex].isMatched {
            if let faceUpCardIndex = indexOfFaceUpCard { // a card is already face up i.e. chosen previously
                if cards[chosenIndex].content == cards[faceUpCardIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[faceUpCardIndex].isMatched = true
                }
                indexOfFaceUpCard = nil
            } else { // no face-up card
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
//        print("chosenCard = \(chosenCard)")
    }
    
    func index(of targetCard: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == targetCard.id {
                return index
            }
        }
        return 0
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        // add numberOfPairsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        var id: Int
    }
}
