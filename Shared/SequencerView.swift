//
//  SequencerView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import SwiftUI

struct SequencerView: View {
    @ObservedObject var conductor: SequencerConductor
    var body: some View {
        VStack {
            ForEach(0 ..< conductor.data.trackCount, id: \.self) { trackIndex in
                HStack {
                    Stepper("", onIncrement: {
                        if conductor.data.trackSignature[trackIndex] < 16 {
                            let trackLength = Double(conductor.data.trackSignature[trackIndex])
                            conductor.data.trackSignature[trackIndex] += 1
                            conductor.sequencer.tracks[trackIndex].length = trackLength
                        }
                    }, onDecrement: {
                        if conductor.data.trackSignature[trackIndex] > 1 {
                            let trackLength = Double(conductor.data.trackSignature[trackIndex])
                            conductor.data.trackSignature[trackIndex] -= 1
                            conductor.sequencer.tracks[trackIndex].length = trackLength
                        }
                    }).frame(width: 100)

                
                    
                    HStack {
                        ForEach(0 ..< conductor.data.trackSignature[trackIndex], id: \.self) { index in
                            
                                Rectangle()
                                    .foregroundColor(conductor.data.noteStatus[trackIndex][index] ? Color(UIColor.darkGray) : Color(UIColor.secondarySystemBackground))
                                    .border(Int(round(conductor.sequencer.tracks[trackIndex].currentPosition)) == index
                                                ? Color(UIColor.darkGray)
                                                : .clear,
                                            width: Int(round(conductor.sequencer.tracks[trackIndex].currentPosition)) == index ? 2 : 1 )
                                    .onTapGesture {
                                        if conductor.data.noteStatus[trackIndex][index] {
                                            conductor.sequencer.tracks[trackIndex].sequence.removeNote(at: Double(index))
                                            conductor.data.noteStatus[trackIndex][index] = false
                                        } else {
                                            conductor.updateSequence(note: conductor.data.notes[trackIndex], position: Double(index), track: trackIndex)
                                            conductor.data.noteStatus[trackIndex][index] = true
                                        }
                                    }
                            
                        }
                    }.frame(height: 32)
                    
                    
                }
            }
        }
    }
}

struct SequencerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
