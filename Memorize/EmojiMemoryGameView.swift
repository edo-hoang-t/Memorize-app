//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by hoang on 04/10/2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
   @ObservedObject var gameViewModel: EmojiMemoryGameVM
    
    var body: some View {
        VStack {
            HStack {
                Text(gameViewModel.themeName)
                    .font(.largeTitle)
                Spacer()
                Text(String(gameViewModel.gameScore))
                    .font(.largeTitle)
            }
            
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], content: {
                    ForEach(gameViewModel.cards, content: {card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                gameViewModel.choose(card)
                            }
                    })
                })
            }
            .foregroundColor(gameViewModel.themeColor)
            
            Spacer()
            
            Button(action: {
                gameViewModel.newGame()
            },label: {
                Text("New game")
                    .font(.title)
            })
            
        }
        .padding(.horizontal)
    }
    
}


struct CardView: View {
    
    let card: EmojiMemoryGameVM.Card
    
    var body: some View {
        GeometryReader(content: {geometry in
            ZStack {
                let roundedRect = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                if card.isFaceUp {
                    roundedRect.foregroundColor(.white)
                    roundedRect.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    roundedRect.opacity(0)
                } else {
                    roundedRect.fill()
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let emojiGameVM = EmojiMemoryGameVM()
        
        EmojiMemoryGameView(gameViewModel: emojiGameVM)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(gameViewModel: emojiGameVM)
            .preferredColorScheme(.light)
            
    }
}

