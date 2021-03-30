//
//  VariableDelayView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-06.
//

import SwiftUI

struct VariableDelayView: View {
    @ObservedObject var conductor: SequencerConductor
    
    var body: some View {
        ZStack {
            Rectangle().cornerRadius(8.0).foregroundColor(Color(UIColor.secondarySystemBackground))
            VStack {
                HStack {
                    Text("Delay")
                    Spacer()
                    Image(systemName: self.conductor.delayData.balance > 0 ? "circle.fill" : "circle")
                        .gesture(TapGesture().onEnded {
                            if self.conductor.delayData.balance > 0 {
                                self.conductor.delayData.balance = 0
                            } else {
                                self.conductor.delayData.balance = 0.1
                            }
                        })
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "clock")
                        Spacer()
                        Slider(value: self.$conductor.delayData.time, in: 0.0 ... 0.5, label: {
                            Text("Time")
                        })
                        .accentColor(.red)
                    }
                    HStack {
                        Image(systemName: "infinity.circle")
                        Spacer()
                        Slider(value: self.$conductor.delayData.feedback, in: 0 ... 1, label: {
                            Text("Feedback")
                        })
                        .accentColor(.red)
                    }
                    HStack {
                        Image(systemName: "dial.min")
                        Spacer()
                        Slider(value: self.$conductor.delayData.balance, in: 0 ... 1, label: {
                            Text("Balance")
                        })
                        .accentColor(.red)
                    }
                }
            }.padding()
            .frame(width: 194, height: 164)
        }
    }
}
