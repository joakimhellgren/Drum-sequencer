//
//  MetronomeView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import SwiftUI

struct MetronomeView: View {
    @ObservedObject var conductor: SequencerConductor
    let lightGray = Color(UIColor.secondarySystemBackground)
    let darkGray = Color(UIColor.darkGray)
    var body: some View {
        HStack {
//            Stepper("", onIncrement: {
//                if conductor.data.metronomeSignature < 16 {
//                    conductor.data.metronomeSignature += 1
//                    conductor.sequencer.tracks[conductor.data.trackCount].length = Double(conductor.data.metronomeSignature)
//                }
//            }, onDecrement: {
//                if conductor.data.metronomeSignature > 1 {
//                    conductor.data.metronomeSignature -= 1
//                    conductor.sequencer.tracks[conductor.data.trackCount].length = Double(conductor.data.metronomeSignature)
//                }
//            })
//            .frame(maxWidth: 100)
            ForEach(0 ..< conductor.data.metronomeSignature, id: \.self) { index in
                ZStack {
                    Circle().foregroundColor(conductor.data.currentBeat[0] == index ? darkGray : .clear)
                    Text("\(index + 1)").foregroundColor(conductor.data.currentBeat[0] == index ? .clear : darkGray)
                        .font(.footnote)
                }
            }
            Group {
                Image(systemName: "timer").resizable().frame(width: 18, height: 18)
            }.frame(width: 32, height: 32)
        }.frame(height: 32)
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
