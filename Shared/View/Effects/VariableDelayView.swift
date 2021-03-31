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
        var data = self.conductor.delayData
        let sliderRef = self.$conductor.delayData
        ZStack {
            Rectangle().cornerRadius(8.0).foregroundColor(Color(UIColor.secondarySystemBackground))
            VStack {
                HStack {
                    Text("Delay")
                    Spacer()
                    Image(systemName: data.balance > 0 ? "circle.fill" : "circle")
                        .gesture(TapGesture().onEnded {
                            if data.balance > 0 {
                                data.balance = 0
                            } else {
                                data.balance = 0.1
                            }
                        })
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "clock")
                        Spacer()
                        Slider(value: sliderRef.time, in: 0.0 ... 0.5, label: {
                            Text("Time")
                        })
                        .accentColor(.red)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                    HStack {
                        Image(systemName: "infinity.circle")
                        Spacer()
                        Slider(value: sliderRef.feedback, in: 0 ... 1, label: {
                            Text("Feedback")
                        })
                        .accentColor(.red)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                    HStack {
                        Image(systemName: "dial.min")
                        Spacer()
                        Slider(value: sliderRef.balance, in: 0 ... 1, label: {
                            Text("Balance")
                        })
                        .accentColor(.red)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                }
            }.padding()
            .frame(width: (UIScreen.main.bounds.width / 4) - 32)
        }
    }
}
