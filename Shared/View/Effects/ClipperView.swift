//
//  ClipperView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-08.
//

import SwiftUI

struct ClipperView: View {
    @ObservedObject var conductor: SequencerConductor
    var body: some View {
        ZStack {
            Rectangle().cornerRadius(8.0).foregroundColor(Color(UIColor.secondarySystemBackground))
            VStack {
                HStack {
                    Text("Clipper")
                    Spacer()
                    Image(systemName: self.conductor.clipperData.balance > 0 ? "circle.fill" : "circle")
                        .gesture(TapGesture().onEnded {
                            if self.conductor.clipperData.balance == 1 {
                                self.conductor.clipperData.balance = 0
                            } else {
                                self.conductor.clipperData.balance = 1
                            }
                        })
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "highlighter")
                        Spacer()
                        Slider(value: self.$conductor.clipperData.limit, in: 0.0 ... 1.0, label: {
                            Text("limit").frame(width: 120)
                        })
                        .frame(width: 120)
                        .accentColor(.green)
                    }
                    HStack {
                        Image(systemName: "dial.min")
                        Spacer()
                        Slider(value: self.$conductor.clipperData.balance, in: 0.1 ... 1.0, label: {
                            Text("balance").frame(width: 120)
                        })
                        .frame(width: 120)
                        .accentColor(.green)
                    }
                }
                
            }.padding(8)
        }
        
    }
}

