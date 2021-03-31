//
//  KorgLowPassFilterView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-06.
//

import SwiftUI

struct KorgLowPassFilterView: View {
    @ObservedObject var conductor: SequencerConductor
    @State var isOn = true
    
    var body: some View {
        ZStack {
            
            Rectangle().cornerRadius(8.0).foregroundColor(Color(UIColor.secondarySystemBackground))
            VStack {
                HStack {
                    Text("Filter")
                    Spacer()
                    Image(systemName: self.conductor.filterData.balance > 0 ? "circle.fill" : "circle")
                        .gesture(TapGesture().onEnded {
                            if self.conductor.filterData.balance == 1 {
                                self.conductor.filterData.balance = 0
                            } else {
                                self.conductor.filterData.balance = 1
                            }
                        })
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "scissors")
                        Spacer()
                        Slider(value: self.$conductor.filterData.cutoffFrequency, in: 0.0 ... 7_000.0, label: {
                            Text("frequency")
                        })
                        .accentColor(.yellow)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                    HStack {
                        Image(systemName: "rotate.3d")
                        Spacer()
                        Slider(value: self.$conductor.filterData.resonance, in: 0.0...0.30, label: {
                            Text("resonance")
                        })
                        .accentColor(.yellow)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                    HStack {
                        Image(systemName: "scribble.variable")
                        Spacer()
                        Slider(value: self.$conductor.filterData.saturation, in: 0.0...10.0, label: {
                            Text("drive")
                        })
                        .accentColor(.yellow)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                }
            }.padding()
            .frame(width: (UIScreen.main.bounds.width / 4) - 32)
        }
        
        
        
        
        
    }
}

