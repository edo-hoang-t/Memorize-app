//
//  EmojiMemoryGameVM.swift
//  Memorize
//
//  Created by hoang on 08/10/2022.
//

import SwiftUI

class EmojiMemoryGameVM: ObservableObject {
    typealias Card = MemoryGameModel<String>.Card
    
    @Published private var gameModel: MemoryGameModel<String>
    private var themeModel: ThemeModel
    
    var cards: Array<Card> {
        return gameModel.cards
    }
    var themeColor: Color {
        return colorFromHex(hex: themeModel.curTheme.themeColor)
    }
    var themeName: String {
        return themeModel.curTheme.themeName
    }
    var gameScore: Int {
        return gameModel.score
    }
    
    init() {
        themeModel = ThemeModel()
        var emojis = themeModel.curTheme.emojiSets
        let maxCards = emojis.count
        emojis.shuffle() // shuffle the set of emojis available in a theme
        gameModel = MemoryGameModel(numberOfPairsOfCards: themeModel.curTheme.numberOfPairsOfCardsForTheme > maxCards ? maxCards : themeModel.curTheme.numberOfPairsOfCardsForTheme) {pairIndex in
            emojis[pairIndex]
        }
    }
    
    func createGameModel() {
        var emojis = themeModel.curTheme.emojiSets
        let maxCards = emojis.count
        emojis.shuffle()
        gameModel = MemoryGameModel(numberOfPairsOfCards: themeModel.curTheme.numberOfPairsOfCardsForTheme > maxCards ? maxCards : themeModel.curTheme.numberOfPairsOfCardsForTheme) {pairIndex in
            emojis[pairIndex]
        }
    }
    
    func choose(_ card: Card) {
        gameModel.choose(card)
    }
    
    func newGame() {
        themeModel.newGame()
        var emojis = themeModel.curTheme.emojiSets
        let maxCards = emojis.count
        emojis.shuffle()
        gameModel = MemoryGameModel(numberOfPairsOfCards: themeModel.curTheme.numberOfPairsOfCardsForTheme > maxCards ? maxCards : themeModel.curTheme.numberOfPairsOfCardsForTheme) {pairIndex in
            emojis[pairIndex]
        }
    }
    
    private func colorFromHex(hex: Int) -> Color {
        return Color(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0)
    }
    
}
