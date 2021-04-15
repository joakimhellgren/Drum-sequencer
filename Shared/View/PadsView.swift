//
//  PadsView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import SwiftUI
import AudioKit
import AVFoundation
import Foundation

struct PadsView: View {
    @ObservedObject var conductor: SequencerConductor
    @State var downPads: [Int] = []
    var isRecording: Bool
    let darkGray = Color(UIColor.darkGray)
    let lightGray = Color(UIColor.secondarySystemBackground)

    var padsAction: (_ padNumber: Int) -> Void
    
    var body: some View {
        VStack {
            
            // most of this code is from the AudioKit Cookbook with some modeifications to fit my use case.
            // https://github.com/AudioKit/Cookbook
            
            ForEach(0..<2, id: \.self) { row in
                HStack {
                    ForEach(0..<4, id: \.self) { column in
                        ZStack {
                            Rectangle()
                                .fill(Color(self.conductor.data.samples[0].map({ self.downPads.contains(where: { $0 == row * 4 + column }) ? .gray : $0.color })[getPadId(row: row, column: column)]))
                                .border(lightGray, width: 1)
                            Text(self.conductor.data.samples[0].map({ $0.name })[getPadId(row: row, column: column)])
                                .foregroundColor(darkGray).fontWeight(.bold)
                                
                        }.cornerRadius(8)
                        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({_ in
                            if !(self.downPads.contains(where: { $0 == row * 4 + column })) {
                                self.padsAction(getPadId(row: row, column: column))
                                self.downPads.append(row * 4 + column)
                                
                                
                                let trackNumber = (row * 4) + column
                                let currentPos = conductor.sequencer.tracks[trackNumber].currentPosition.rounded()
                                if currentPos > 15 {
                                    return
                                }
                                if !conductor.data.noteStatus[trackNumber][Int(currentPos.rounded() > 15 ? 15 : currentPos.rounded())] && isRecording {
                                    conductor.updateSequence(note: conductor.data.notes[trackNumber], position: currentPos > 15 ? 15 : currentPos, track: trackNumber)
                                    conductor.data.noteStatus[trackNumber][Int(currentPos > 15.0 ? 15.0 : currentPos)] = true
                                }
                            }
                        }).onEnded({_ in
                            self.downPads.removeAll(where: { $0 == row * 4 + column })
                        }))
                    }
                }
            }
        }
    }
}



private func getPadId(row: Int, column: Int) -> Int {
    return (row * 4) + column
}
