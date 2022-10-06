//
//  ContentView.swift
//  Memorize
//
//  Created by hoang on 04/10/2022.
//

import SwiftUI


struct ContentView: View {

    let plantEmojis = ["🌱", "🌲", "🌳", "🌴", "🌵", "🌷", "🌸", "🌹", "🌺", "🌻", "🌼", "🌾", "🌿", "🍀", "🍁", "🍂", "🥀", "🍃", "🍄", "🎄", "🪷", "☘️", "💐"]
    let plantColorTheme = Color.green
    
    let vehicleEmojis = ["🚗", "✈️", "🚁", "🚲", "🚢", "🛶", "🚀", "🛻", "🚚", "🚂", "🚠", "🚄", "🚜", "🏍", "🛴", "🛵"]
    let vehicleColorTheme = Color.red
    
    let drinkEmojis = ["🥃", "🥛", "🥤", "🍹", "🧃", "🧉", "🧋", "🫖", "🍻", "🍾", "🥂", "🫗", "🍵", "🍶", "🍷", "🍸", "🍺", "☕️"]
    let drinkColorTheme = Color.blue
    
    @State var emojis = ["🌱", "🌲", "🌳", "🌴", "🌵", "🌷", "🌸", "🌹", "🌺", "🌻", "🌼", "🌾", "🌿", "🍀", "🍁", "🍂", "🥀", "🍃", "🍄", "🎄", "🪷", "☘️", "💐"]
    @State var themeColor = Color.green
    @State var emojiCount = 10
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], content: {
                    ForEach(emojis[0..<emojiCount], id: \.self, content: {emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    })
                })
            }
            .foregroundColor(themeColor)
            
            Spacer()
            HStack {
                plantButton
                vehicleButton
                drinkButton
            }
            
        }
        .padding(.horizontal)
    }
    
    var plantButton: some View {
        Button(action: {
            self.emojis = plantEmojis
            self.emojis.shuffle()
            self.themeColor = plantColorTheme
        }, label: {
            VStack {
                Image(systemName: "leaf.circle")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("Plants")
            }
            .frame(height: 70.0)
            
        })
    }
    
    var vehicleButton: some View {
        Button(action: {
            self.emojis = vehicleEmojis
            self.emojis.shuffle()
            self.themeColor = vehicleColorTheme
        }, label: {
            VStack {
                Image(systemName: "car")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("Vehicles")
                    
            }
            .frame(height: 70.0)
        })
    }
    
    var drinkButton: some View {
        Button(action: {
            self.emojis = drinkEmojis
            self.emojis.shuffle()
            self.themeColor = drinkColorTheme
        }, label: {
            VStack {
                Image(systemName: "cup.and.saucer.fill")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("Drinks")
            }
            .frame(height: 70.0)
        })
    }
    
}


struct CardView: View {
    
    var content: String
    
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let roundedRect = RoundedRectangle(cornerRadius: 25)
            
            if isFaceUp {
                roundedRect.foregroundColor(.white)
                roundedRect.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                roundedRect.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
            
    }
}

