//
//  ContentView.swift
//  Shared
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var kit = 0
    @State var kitSelectionActive: Bool = true
    
    var body: some View {
        ZStack {
            if kitSelectionActive {
                VStack {
                    Text("choose kit")
                    HStack {
                        Text("kit 1")
                            .onTapGesture {
                                self.kit = 0
                                self.kitSelectionActive.toggle()
                            }
                        Text("kit 2")
                            .onTapGesture {
                                self.kit = 1
                                self.kitSelectionActive.toggle()
                            }
                        Text("kit 3")
                            .onTapGesture {
                                self.kit = 2
                                self.kitSelectionActive.toggle()
                            }
                    }
                }
            } else {
                MainView(kitSelectionActive: $kitSelectionActive, kit: kit)
            }
        }
        .animation(.easeInOut)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 NavigationLink(destination: MainView(kit: kit), label: {
 Text("Kit 1")
 })
 */
