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
    //@ObservedObject var conductor: SequencerConductor
    var body: some View {
        VStack {
            ForEach(0 ..< conductor.data.trackCount, id: \.self) { trackIndex in
                Group {
                    Image(systemName: isMuted[trackIndex] ? "speaker.slash.fill" : "speaker.slash").resizable()
                        .frame(width: 20, height: 20)
                        .onTapGesture(perform: {
                            isMuted[trackIndex].toggle()
                            if isMuted[trackIndex] {
                                sequences[trackIndex].append(conductor.sequencer.tracks[trackIndex].sequence)
                                conductor.sequencer.tracks[trackIndex].clear()
                            } else {
                                conductor.sequencer.tracks[trackIndex].sequence = sequences[trackIndex][0]
                                sequences[trackIndex].removeAll()
                            }
                        })
                }.frame(width: 32, height: 32)
            }
        }
        
    }
}


