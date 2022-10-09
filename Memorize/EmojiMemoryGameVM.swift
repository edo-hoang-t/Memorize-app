//
//  EmojiMemoryGameVM.swift
//  Memorize
//
//  Created by hoang on 08/10/2022.
//

import SwiftUI

class EmojiMemoryGameVM: ObservableObject {
    
    static let emojis = ["🚗", "✈️", "🚁", "🚲", "🚢", "🛶", "🚀", "🛻", "🚚", "🚂", "🚠", "🚄", "🚜", "🏍", "🛴", "🛵"]
    
    static func createMemoryGameModel() -> MemoryGameModel<String> {
        MemoryGameModel(numberOfPairsOfCards: 4) {pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGameModel<String> = createMemoryGameModel()
        
    var cards: Array<MemoryGameModel<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
    
}
