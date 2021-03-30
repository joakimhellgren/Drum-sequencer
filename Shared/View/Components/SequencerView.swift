//
//  SequencerView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import SwiftUI
import AudioKit

struct SequencerView: View {
    @ObservedObject var conductor: SequencerConductor
    // track state. Muting a track will remove all events from it
    @State var isMuted = [false, false, false, false, false, false, false, false]
    // var sequences is used whenever we need to reference, or store the currently playing sequence.
    // we use this functionality when a track is about to bemuted
    // we need this reference when we want to mute a track.
    @State var sequences: [[NoteEventSequence]] = [[], [], [], [], [], [], [], []]
    
    // set color for our mute button to indicate if a track is playing or not
    func colorSetter(status: [Bool], pos: Int) -> Color {
        if isMuted[pos] { return Color.red } else { return Color.primary }
    }
    
    var body: some View {
        VStack {
            // a menu for setting the time signature for every track
            ForEach(0 ..< conductor.data.trackCount, id: \.self) { trackIndex in
                HStack {
                    Group {
                        Menu("\(conductor.data.trackSignature[trackIndex])") {
                            ForEach(1 ... 16, id: \.self) { timeIndex in
                                Button("\(timeIndex)") {
                                    conductor.sequencer.tracks[trackIndex].length = Double(timeIndex)
                                    conductor.data.trackSignature[trackIndex] = timeIndex
                                }
                            }
                        }
                    }.frame(minWidth: 32, minHeight: 28)
                    
                    // main sequenencer, aka nodes. Each track has a maximum of 16 nodes and a minimum of 1 node.
                    HStack {
                        ForEach(0 ..< conductor.data.trackSignature[trackIndex], id: \.self) { index in
                            Rectangle()
                                // when the index of a node matches the currently index of the playing track we change the color of the node
                                .foregroundColor(conductor.data.noteStatus[trackIndex][index] ? Color(UIColor.darkGray) : Color(UIColor.secondarySystemBackground))
                                .border(Int(round(conductor.sequencer.tracks[trackIndex].currentPosition)) == index
                                            ? Color(UIColor.darkGray)
                                            : .clear,
                                        width: Int(round(conductor.sequencer.tracks[trackIndex].currentPosition)) == index ? 2 : 1 )
                                .gesture(TapGesture().onEnded {
                                    // if there is a note on the selected node we remove it.
                                    if conductor.data.noteStatus[trackIndex][index] {
                                        // prevent input of notes if track is currently muted.
                                        if isMuted[trackIndex] { return }
                                        conductor.sequencer.tracks[trackIndex].sequence.removeNote(at: Double(index))
                                        conductor.data.noteStatus[trackIndex][index] = false
                                    }
                                    // else we add a note to the selected node
                                    else {
                                        if isMuted[trackIndex] { return }
                                        conductor.updateSequence(note: conductor.data.notes[trackIndex], position: Double(index), track: trackIndex)
                                        conductor.data.noteStatus[trackIndex][index] = true
                                    }
                                })
                        }
                    }.frame(minWidth: 100, minHeight: 7)
                    
                    // mute a track.
                    Button("M") {
                        isMuted[trackIndex].toggle()
                        if isMuted[trackIndex] {
                            sequences[trackIndex].append(conductor.sequencer.tracks[trackIndex].sequence)
                            conductor.sequencer.tracks[trackIndex].clear()
                        } else {
                            conductor.sequencer.tracks[trackIndex].sequence = sequences[trackIndex][0]
                            sequences[trackIndex].removeAll()
                        }
                    }.frame(width: 48, height: 32).foregroundColor(colorSetter(status: isMuted, pos: trackIndex))
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
