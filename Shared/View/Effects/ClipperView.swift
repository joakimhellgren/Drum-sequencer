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
        var data = self.conductor.clipperData
        let sliderRef = self.$conductor.clipperData
        ZStack {
            Rectangle().cornerRadius(8.0).foregroundColor(Color(UIColor.secondarySystemBackground))
            VStack {
                HStack {
                    Text("Clipper")
                    Spacer()
                    Image(systemName: data.balance > 0 ? "circle.fill" : "circle")
                        .gesture(TapGesture().onEnded {
                            if data.balance == 1 {
                                data.balance = 0
                            } else {
                                data.balance = 1
                            }
                        })
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "highlighter")
                        Spacer()
                        Slider(value: sliderRef.limit, in: 0.0 ... 1.0, label: {
                            Text("limit")
                        })
                        .accentColor(.green)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                    HStack {
                        Image(systemName: "dial.min")
                        Spacer()
                        Slider(value: sliderRef.balance, in: 0.1 ... 1.0, label: {
                            Text("balance")
                        })
                        .accentColor(.green)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                }
            }.padding()
            .frame(width: (UIScreen.main.bounds.width / 4) - 32)
        }
    }
}

