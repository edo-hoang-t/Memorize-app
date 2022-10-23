//
//  ThemeModel.swift
//  Memorize
//
//  Created by hoang on 12/10/2022.
//

import Foundation

struct ThemeModel {
    
    var themes: Array<Theme> = [
        Theme(themeName: "Vehicles", emojiSets: ["🚗", "✈️", "🚁", "🚲", "🚢", "🛶", "🚀", "🛻", "🚚", "🚂", "🚠", "🚄", "🚜", "🏍", "🛴", "🛵"], themeColor: 0xFF0000, numberOfPairsOfCardsForTheme: 7),
        Theme(themeName: "Plants", emojiSets: ["🌱", "🌲", "🌳", "🌴", "🌵", "🌷", "🌸", "🌹", "🌺", "🌻", "🌼", "🌾", "🌿", "🍀", "🍁", "🍂", "🥀", "🍃", "🍄", "🎄", "🪷", "☘️", "💐"], themeColor: 0x00FF00, numberOfPairsOfCardsForTheme: 9),
        Theme(themeName: "Drinks", emojiSets: ["🥃", "🥛", "🥤", "🍹", "🧃", "🧉", "🧋", "🫖", "🍻", "🍾", "🥂", "🫗", "🍵", "🍶", "🍷", "🍸", "🍺", "☕️"], themeColor: 0x0000FF, numberOfPairsOfCardsForTheme: 8),
        Theme(themeName: "Animals", emojiSets: ["🦑", "🦋", "🐟", "🐊", "🦓", "🐧", "🦆", "🐜", "🐝", "🐳", "🦕", "🦩"], themeColor: 0x7F601F, numberOfPairsOfCardsForTheme: 10),
        Theme(themeName: "Flags", emojiSets: ["🏳️‍🌈", "🏳️‍⚧️", "🇺🇳", "🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇮", "🇧🇪", "🇻🇳", "🇺🇸", "🇭🇰"], themeColor: 0xE86C38, numberOfPairsOfCardsForTheme: 6),
        Theme(themeName: "Faces", emojiSets: ["😀", "🤣", "🥰", "🥳", "🧐", "😓", "😡", "🫡", "😴", "😋", "🥺"], themeColor: 0xFFFF00, numberOfPairsOfCardsForTheme: 8)
    ]
    
    private(set) var curTheme: Theme
    
    init() {
        curTheme = themes[Int.random(in: 0..<themes.count)]
    }
    
    mutating func newGame() {
        curTheme = themes[Int.random(in: 0..<themes.count)]
    }
    
    struct Theme {
        var themeName: String
        var emojiSets: Array<String>
        var themeColor: Int
        var numberOfPairsOfCardsForTheme: Int
    }
    
}
