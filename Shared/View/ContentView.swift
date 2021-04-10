//
//  ContentView.swift
//  Shared
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var kit = 7
    @State var kitSelectionActive: Bool = false
    
    var body: some View {
        MainView(kitSelectionActive: $kitSelectionActive, kit: kit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
