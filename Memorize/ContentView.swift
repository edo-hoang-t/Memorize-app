//
//  ContentView.swift
//  Memorize
//
//  Created by hoang on 04/10/2022.
//

import SwiftUI


struct ContentView: View {
    
   @ObservedObject var viewModel: EmojiMemoryGameVM
    
    var body: some View {
        VStack {
            Text(viewModel.themeName)
                .font(.largeTitle)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], content: {
                    ForEach(viewModel.cards, content: {card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    })
                })
            }
            .foregroundColor(viewModel.themeColor)
            
            Spacer()
            
            Button(action: {
                viewModel.newGame()
            },label: {
                Text("New game")
                    .font(.title)
            })
            
        }
        .padding(.horizontal)
    }
    
}


struct CardView: View {
    
    let card: MemoryGameModel<String>.Card
    
    var body: some View {
        ZStack {
            let roundedRect = RoundedRectangle(cornerRadius: 25)
            
            if card.isFaceUp {
                roundedRect.foregroundColor(.white)
                roundedRect.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                roundedRect.opacity(0)
            } else {
                roundedRect.fill()
            }
        }
    }
    
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let emojiGameVM = EmojiMemoryGameVM()
        
        ContentView(viewModel: emojiGameVM)
            .preferredColorScheme(.dark)
        ContentView(viewModel: emojiGameVM)
            .preferredColorScheme(.light)
            
    }
}

