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
        ZStack {
            Rectangle().cornerRadius(8.0).foregroundColor(Color(UIColor.secondarySystemBackground))
            VStack {
                HStack {
                    Text("Reverb")
                    Spacer()
                    Image(systemName: self.conductor.reverbData.balance > 0 ? "circle.fill" : "circle")
                        .gesture(TapGesture().onEnded {
                            if self.conductor.reverbData.balance == 1 {
                                self.conductor.reverbData.balance = 0
                            } else {
                                self.conductor.reverbData.balance = 0.3
                            }
                        })
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "infinity.circle")
                        Spacer()
                        Slider(value: self.$conductor.reverbData.feedback, in: 0.0 ... 1.0, label: {
                            Text("Feedback")
                        }).frame(width: 120)
                        .accentColor(.blue)
                    }
                    HStack {
                        Image(systemName: "scissors")
                        Spacer()
                        Slider(value: self.$conductor.reverbData.cutoffFrequency, in: 0.0 ... 7_000.0, label: {
                            Text("Cutoff")
                        }).frame(width: 120)
                        .accentColor(.blue)
                    }
                    HStack {
                        Image(systemName: "dial.min")
                        Spacer()
                        Slider(value: self.$conductor.reverbData.balance, in: 0 ... 1, label: {
                            Text("Balance")
                        }).frame(width: 120)
                        .accentColor(.blue)
                    }
                }
            }.padding(8)
        }
    }
}

