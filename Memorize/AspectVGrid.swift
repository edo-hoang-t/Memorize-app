//
//  AspectVGrid.swift
//  Memorize
//
//  Created by hoang on 23/10/2022.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                LazyVGrid(columns: [itemColumnWithoutSpace(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func itemColumnWithoutSpace(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var numCol = 1
        var numRow = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(numCol)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(numRow) * itemHeight < size.height {
                break
            }
            numCol += 1
            numRow = (itemCount + (numCol - 1)) / numCol
        } while numCol < itemCount
        
        if numCol > itemCount {
            numCol = itemCount
        }
        return floor(size.width / CGFloat(numCol))
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
