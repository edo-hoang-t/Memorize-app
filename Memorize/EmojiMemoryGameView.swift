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
            
            AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            gameViewModel.choose(card)
                        }
                }
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
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20)).padding(5).opacity(DrawingConstants.pieOpacity)
                    Text(card.content)
                        .font(font(in: geometry.size))
                }
//                else if card.isMatched { // move this part above to make use of @ViewBuilder
//                    roundedRect.opacity(0)
//                }
                else {
                    roundedRect.fill()
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let pieOpacity: CGFloat = 0.5
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let emojiGameVM = EmojiMemoryGameVM()
        emojiGameVM.choose(emojiGameVM.cards.first!)
        return EmojiMemoryGameView(gameViewModel: emojiGameVM)
            .preferredColorScheme(.light)
            
    }
}

