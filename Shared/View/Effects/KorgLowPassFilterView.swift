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
                    Text("fltr:")
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
                        Text("frq")
                        Spacer()
                        Slider(value: self.$conductor.filterData.cutoffFrequency, in: 0.0 ... 7_000.0, label: {
                            Text("frequency")
                        }).frame(width: 120)
                        .accentColor(.yellow)
                    }
                    HStack {
                        Text("rsns")
                        Spacer()
                        Slider(value: self.$conductor.filterData.resonance, in: 0.0...0.30, label: {
                            Text("resonance")
                        }).frame(width: 120)
                        .accentColor(.yellow)
                    }
                    HStack {
                        Text("drv")
                        Spacer()
                        Slider(value: self.$conductor.filterData.saturation, in: 0.0...10.0, label: {
                            Text("drive")
                        }).frame(width: 120)
                        .accentColor(.yellow)
                    }
                }
            }.padding(8)
        }
        
        
        
        
    }
}

