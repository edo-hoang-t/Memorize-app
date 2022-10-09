//
//  MemorizeApp.swift
//  Memorize
//
//  Created by hoang on 04/10/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let emojiGameVM = EmojiMemoryGameVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: emojiGameVM)
        }
    }
}
