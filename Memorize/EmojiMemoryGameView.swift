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
                Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20)).padding(5).opacity(DrawingConstants.pieOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
//                    .font(font(in: geometry.size))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        })
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let pieOpacity: CGFloat = 0.3
        static let fontSize: CGFloat = 32
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let emojiGameVM = EmojiMemoryGameVM()
        return EmojiMemoryGameView(gameViewModel: emojiGameVM)
            .preferredColorScheme(.light)

    }
}


struct Previews_EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

