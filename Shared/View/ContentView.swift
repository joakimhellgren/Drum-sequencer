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
                    Spacer()
                
                    Text("choose a kit").frame(height: 84).font(.title)
                    
                    HStack {
                        Text("1").font(.headline).frame(width: 84, height: 84)
                            .onTapGesture {
                                self.kit = 0
                                self.kitSelectionActive.toggle()
                            }
                        Text("2").font(.headline).frame(width: 84, height: 84)
                            .onTapGesture {
                                self.kit = 1
                                self.kitSelectionActive.toggle()
                            }
                        Text("3").font(.headline).frame(width: 84, height: 84)
                            .onTapGesture {
                                self.kit = 2
                                self.kitSelectionActive.toggle()
                            }
                        Text("4").font(.headline).frame(width: 84, height: 84)
                            .onTapGesture {
                                self.kit = 3
                                self.kitSelectionActive.toggle()
                            }
                        Text("5").font(.headline).frame(width: 84, height: 84)
                            .onTapGesture {
                                self.kit = 4
                                self.kitSelectionActive.toggle()
                            }
                        Text("6").font(.headline).frame(width: 84, height: 84)
                            .onTapGesture {
                                self.kit = 5
                                self.kitSelectionActive.toggle()
                            }
                    }
                    Spacer()
                }
            } else {
                MainView(kitSelectionActive: $kitSelectionActive, kit: kit)
            }
        }
        .padding()
//        .animation(.easeInOut(duration: 0.1))
        
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
