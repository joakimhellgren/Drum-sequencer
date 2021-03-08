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
                    Text("Delay:")
                    Image(systemName: self.conductor.delayData.balance > 0 ? "circle.fill" : "circle")
                        .onTapGesture {
                            if self.conductor.delayData.balance > 0 {
                                self.conductor.delayData.balance = 0
                            } else {
                                self.conductor.delayData.balance = 0.1
                            }
                        }
                    
                }
                
                
                    VStack {
                        Slider(value: self.$conductor.delayData.time, in: 0...1, label: {
                            Text("Time")
                        })
                        Slider(value: self.$conductor.delayData.feedback, in: 0...1, label: {
                            Text("Feedback")
                        })
                        Slider(value: self.$conductor.delayData.balance, in: 0...1, label: {
                            Text("Balance")
                        })
                    }.padding(8)
               
                    
                }
            
            
        }
    }
}
