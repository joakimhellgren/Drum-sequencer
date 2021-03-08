//
//  KorgLowPassFilterView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-06.
//

import SwiftUI

struct KorgLowPassFilterView: View {
    @ObservedObject var conductor: SequencerConductor
    @State var gestureValue = CGSize.zero
    
    var body: some View {
        ZStack {
            Rectangle().cornerRadius(8.0).foregroundColor(Color(UIColor.secondarySystemBackground))
            VStack {
                
            HStack {
                
                Text("Filter:")
                Image(systemName: self.conductor.filterData.balance == 1 ? "circle.fill" : "circle")
                    .onTapGesture {
                        if self.conductor.filterData.balance == 1 {
                            self.conductor.filterData.balance = 0
                        } else {
                            self.conductor.filterData.balance = 1
                        }
                    }
                
            }
            
         
              
                    
                    VStack {
                        Slider(value: self.$conductor.filterData.cutoffFrequency, in: 0.0 ... 7_000.0, label: {
                            Text("frequency")
                        })
                        Slider(value: self.$conductor.filterData.resonance, in: 0.0...0.30, label: {
                            Text("resonance")
                        })
                        Slider(value: self.$conductor.filterData.saturation, in: 0.0...10.0, label: {
                            Text("drive")
                        })
                    }.padding(8)
            }
            }
            
            
            
        
    }
}

