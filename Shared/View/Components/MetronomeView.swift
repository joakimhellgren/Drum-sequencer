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
        // nodes for the metronome track (see sequencerview.swift for reference)
        HStack {
            ForEach(0 ..< conductor.data.metronomeSignature, id: \.self) { index in
                ZStack {
                    Circle().foregroundColor(conductor.data.currentBeat[0] == index ? darkGray : .clear)
                    Text("•").foregroundColor(conductor.data.currentBeat[0] == index ? .primary : darkGray)
                        .font(.footnote)
                }
            }
            Group {
                // displays current bpm (not sure if this is the correct equation for BPM)
                Text("\(Int(conductor.data.tempo / 4))").foregroundColor(.primary)
                    .font(.footnote)
            }.frame(width: 24, height: 24)
        }.frame(height: 32)
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
