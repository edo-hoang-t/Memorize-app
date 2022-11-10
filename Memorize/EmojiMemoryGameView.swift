//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by hoang on 04/10/2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var gameViewModel: EmojiMemoryGameVM
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Text(gameViewModel.themeName)
                        .font(.largeTitle)
                    Spacer()
                    Text(String(gameViewModel.gameScore))
                        .font(.largeTitle)
                }
                
                gameBody
                
                Spacer()
                
                HStack {
                    newGame
                    Spacer()
                    shuffle
                }
                .padding(.vertical)
                
            }
            deckBody
        }
        .padding()
    }
    
    var newGame: some View {
        Button(action: {
            withAnimation {
                dealt = []
                gameViewModel.newGame()
            }
        },label: {
            Text("New game")
                .font(.title)
        })
    }
    
    var shuffle: some View {
        Button(action: {
            withAnimation {
                gameViewModel.shuffle()
            }
        },label: {
            Text("Shuffle")
                .font(.title)
        })
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGameVM.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGameVM.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGameVM.Card) -> Animation {
        var delay: Double = 0.0
        if let index = gameViewModel.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(gameViewModel.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGameVM.Card) -> Double {
        -Double(gameViewModel.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: gameViewModel.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            gameViewModel.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(gameViewModel.themeColor)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(gameViewModel.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(gameViewModel.themeColor)
        .onTapGesture {
            // "deals" card
            for card in gameViewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    private struct CardConstants {
        static let aspectRatio : CGFloat = 2/3
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
        static let dealDuration = 0.5
        static let totalDealDuration = 2.0
    }
    
}


struct CardView: View {
    
    let card: EmojiMemoryGameVM.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader(content: {geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }.padding(5).opacity(DrawingConstants.pieOpacity)
                Text(card.content)
                    .animation(Animation.linear(duration: 0))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
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


struct Previews_EmojiMemoryGameView_Previews_2: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
