//
//  IntroGame.swift
//  MemoryGame
//
//  Created by Gabriel Lucas Santos on 04/04/21.
//

import SwiftUI

struct IntroGameView: View {
    private let viewModelFaces = MemoryGameViewModel(theme: .FACE)
    private let viewModelFood = MemoryGameViewModel(theme: .FOOD)
    private let viewModelAnimal = MemoryGameViewModel(theme: .ANIMAL)
    
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: MemoryGameView(viewModel: viewModelFood)) {
                        Text("Food theme")
                }
                NavigationLink(destination: MemoryGameView(viewModel: viewModelFaces)) {
                        Text("Faces Theme")
                }
                NavigationLink(destination: MemoryGameView(viewModel: viewModelAnimal)) {
                        Text("Animal Theme")
                }
            }
        
            .navigationTitle("Game Memory")
            
        }
    }
}

struct IntroGame_Previews: PreviewProvider {
    static var previews: some View {
        IntroGameView()
    }
}
