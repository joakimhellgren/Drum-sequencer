//
//  CostelloReverbView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-08.
//

import SwiftUI

struct CostelloReverbView: View {
    @ObservedObject var conductor: SequencerConductor
    var body: some View {
        var data = self.conductor.reverbData
        let sliderRef = self.$conductor.reverbData
        ZStack {
            Rectangle().cornerRadius(8.0).foregroundColor(Color(UIColor.secondarySystemBackground))
            VStack {
                HStack {
                    Text("Reverb")
                    Spacer()
                    Image(systemName: data.balance > 0 ? "circle.fill" : "circle")
                        .gesture(TapGesture().onEnded {
                            if data.balance == 1 {
                                data.balance = 0
                            } else {
                                data.balance = 0.3
                            }
                        })
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "infinity.circle")
                        Spacer()
                        Slider(value: sliderRef.feedback, in: 0.0 ... 1.0, label: {
                            Text("Feedback")
                        })
                        .accentColor(.blue)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                    HStack {
                        Image(systemName: "scissors")
                        Spacer()
                        Slider(value: sliderRef.cutoffFrequency, in: 0.0 ... 7_000.0, label: {
                            Text("Cutoff")
                        })
                        .accentColor(.blue)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                    HStack {
                        Image(systemName: "dial.min")
                        Spacer()
                        Slider(value: sliderRef.balance, in: 0 ... 1, label: {
                            Text("Balance")
                        })
                        .accentColor(.blue)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                }
            }.padding()
            .frame(width: (UIScreen.main.bounds.width / 4) - 32)
        }
    }
}

