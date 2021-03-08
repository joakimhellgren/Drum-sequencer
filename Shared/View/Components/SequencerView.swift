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
    @State var isMuted = [false, false, false, false, false, false, false, false]
    @State var sequences: [[NoteEventSequence]] = [[], [], [], [], [], [], [], []]
    
    func colorSetter(status: [Bool], pos: Int) -> Color {
        if isMuted[pos] { return Color.red } else { return Color.primary }
    }
    
    var body: some View {
        VStack {
            ForEach(0 ..< conductor.data.trackCount, id: \.self) { trackIndex in
                HStack {
                    Group {
                        Button("-") {
                            if conductor.data.trackSignature[trackIndex] > 1 {
                                conductor.data.trackSignature[trackIndex] -= 1
                                let trackLength = Double(conductor.data.trackSignature[trackIndex])
                                
                                conductor.sequencer.tracks[trackIndex].length = trackLength
                            }
                        }.accentColor(.primary)
                        
                        Button("+") {
                            if conductor.data.trackSignature[trackIndex] < 16 {
                                
                                conductor.data.trackSignature[trackIndex] += 1
                                let trackLength = Double(conductor.data.trackSignature[trackIndex])
                                conductor.sequencer.tracks[trackIndex].length = trackLength
                            }
                        }.accentColor(.primary)
                    }.frame(minWidth: 32, minHeight: 28)
                    

                
                    
                    HStack {
                        ForEach(0 ..< conductor.data.trackSignature[trackIndex], id: \.self) { index in
                            
                            Rectangle()
                                    .foregroundColor(conductor.data.noteStatus[trackIndex][index] ? Color(UIColor.darkGray) : Color(UIColor.secondarySystemBackground))
                                    .border(Int(round(conductor.sequencer.tracks[trackIndex].currentPosition)) == index
                                                ? Color(UIColor.darkGray)
                                                : .clear,
                                            width: Int(round(conductor.sequencer.tracks[trackIndex].currentPosition)) == index ? 2 : 1 )
                                .gesture(TapGesture().onEnded {
                                        if conductor.data.noteStatus[trackIndex][index] {
                                            conductor.sequencer.tracks[trackIndex].sequence.removeNote(at: Double(index))
                                            conductor.data.noteStatus[trackIndex][index] = false
                                        } else {
                                            conductor.updateSequence(note: conductor.data.notes[trackIndex], position: Double(index), track: trackIndex)
                                            conductor.data.noteStatus[trackIndex][index] = true
                                        }
                                    })
                            
                        }
                    }.frame(minWidth: 400, minHeight: 28)
                    
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
