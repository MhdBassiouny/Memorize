//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Muhammad Bassiouny on 8/26/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        @StateObject var game = EmojiMemoryGame()
        
        WindowGroup {
            NavigationView{
                EmojiMemoryGameView(viewModel: game)
            }
        }
    }
}
