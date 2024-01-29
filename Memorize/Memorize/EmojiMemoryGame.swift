//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Muhammad Bassiouny on 9/2/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🐻‍❄️", "🐮", "🐵", "🐨", "🦆", "🐦‍⬛", "🦅", "🦉", "🐴", "🐝", "🐌", "🪲", "🪰", "🪳"]
    
    @Published private var model = MemoryGame(numberOfPairsOfCards: 15) { pairIndex in
        if emojis.indices.contains(pairIndex) {
            return emojis[pairIndex]
        } else {
            return "⁉️"
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var color: Color {
        .orange
    }
    
    var score: Int {
        model.score
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    //MARK: - User Intent
    func shuffle() {
        model.shuffle()
    }
}
