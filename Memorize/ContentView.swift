//
//  ContentView.swift
//  Memorize
//
//  Created by hoang on 04/10/2022.
//

import SwiftUI


struct ContentView: View {
    
   @ObservedObject var viewModel: EmojiMemoryGameVM

//    let plantEmojis = ["🌱", "🌲", "🌳", "🌴", "🌵", "🌷", "🌸", "🌹", "🌺", "🌻", "🌼", "🌾", "🌿", "🍀", "🍁", "🍂", "🥀", "🍃", "🍄", "🎄", "🪷", "☘️", "💐"]
//    let plantColorTheme = Color.green
//
//    let vehicleEmojis = ["🚗", "✈️", "🚁", "🚲", "🚢", "🛶", "🚀", "🛻", "🚚", "🚂", "🚠", "🚄", "🚜", "🏍", "🛴", "🛵"]
//    let vehicleColorTheme = Color.red
//
//    let drinkEmojis = ["🥃", "🥛", "🥤", "🍹", "🧃", "🧉", "🧋", "🫖", "🍻", "🍾", "🥂", "🫗", "🍵", "🍶", "🍷", "🍸", "🍺", "☕️"]
//    let drinkColorTheme = Color.blue
    
    
    var body: some View {
        VStack {
            Text("Memorize!")
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
//            .foregroundColor(themeColor)
            
            Spacer()
//            HStack {
//                plantButton
//                vehicleButton
//                drinkButton
//            }
            
        }
        .padding(.horizontal)
    }
    
//    var plantButton: some View {
//        Button(action: {
//            self.emojis = plantEmojis
//            self.emojis.shuffle()
//            self.themeColor = plantColorTheme
//        }, label: {
//            VStack {
//                Image(systemName: "leaf.circle")
//                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
//                Spacer()
//                Text("Plants")
//            }
//            .frame(height: 70.0)
//
//        })
//    }
//
//    var vehicleButton: some View {
//        Button(action: {
//            self.emojis = vehicleEmojis
//            self.emojis.shuffle()
//            self.themeColor = vehicleColorTheme
//        }, label: {
//            VStack {
//                Image(systemName: "car")
//                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
//                Spacer()
//                Text("Vehicles")
//
//            }
//            .frame(height: 70.0)
//        })
//    }
//
//    var drinkButton: some View {
//        Button(action: {
//            self.emojis = drinkEmojis
//            self.emojis.shuffle()
//            self.themeColor = drinkColorTheme
//        }, label: {
//            VStack {
//                Image(systemName: "cup.and.saucer.fill")
//                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
//                Spacer()
//                Text("Drinks")
//            }
//            .frame(height: 70.0)
//        })
//    }
    
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

