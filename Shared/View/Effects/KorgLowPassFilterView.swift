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
        var data = self.conductor.filterData
        let sliderRef = self.$conductor.filterData
        ZStack {
            Rectangle().cornerRadius(8.0).foregroundColor(Color(UIColor.secondarySystemBackground))
            VStack {
                HStack {
                    Text("Filter")
                    Spacer()
                    Image(systemName: data.balance > 0 ? "circle.fill" : "circle")
                        .gesture(TapGesture().onEnded {
                            if data.balance == 1 { data.balance = 0 } else { data.balance = 1 }
                        })
                }
                Spacer()
                VStack {
                    HStack {
                        Image(systemName: "scissors")
                        Spacer()
                        Slider(value: sliderRef.cutoffFrequency, in: 0.0 ... 7_000.0, label: {
                            Text("frequency")
                        })
                        .accentColor(.yellow)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                    HStack {
                        Image(systemName: "rotate.3d")
                        Spacer()
                        Slider(value: sliderRef.resonance, in: 0.0...0.30, label: {
                            Text("resonance")
                        })
                        .accentColor(.yellow)
                    }.frame(width: UIScreen.main.bounds.width / 3)
                    HStack {
                        Image(systemName: "scribble.variable")
                        Spacer()
                        Slider(value: sliderRef.saturation, in: 0.0...10.0, label: {
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

