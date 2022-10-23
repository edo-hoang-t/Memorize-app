//
//  MemorizeApp.swift
//  Memorize
//
//  Created by hoang on 04/10/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    private let emojiGameVM = EmojiMemoryGameVM()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(gameViewModel: emojiGameVM)
        }
    }
}
