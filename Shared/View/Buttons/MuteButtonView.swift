//
//  MuteButtonView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-05.
//

import SwiftUI
import AudioKit

struct MuteButtonView: View {
    @ObservedObject var conductor: SequencerConductor
    @State var isMuted = [false, false, false, false, false, false, false, false]
    @State var sequences: [[NoteEventSequence]] = [[], [], [], [], [], [], [], []]
    
    func colorSetter(status: [Bool], pos: Int) -> Color {
        if isMuted[pos] { return Color.red } else { return Color.primary }
    }
    
    var body: some View {
        VStack {
            ForEach(0 ..< conductor.data.trackCount, id: \.self) { trackIndex in
                Group {
                    Button("M") {
                        isMuted[trackIndex].toggle()
                        if isMuted[trackIndex] {
                            sequences[trackIndex].append(conductor.sequencer.tracks[trackIndex].sequence)
                            conductor.sequencer.tracks[trackIndex].clear()
                        } else {
                            conductor.sequencer.tracks[trackIndex].sequence = sequences[trackIndex][0]
                            sequences[trackIndex].removeAll()
                        }
                    }
                }.foregroundColor(colorSetter(status: isMuted, pos: trackIndex))
            }
        }
    }
}


