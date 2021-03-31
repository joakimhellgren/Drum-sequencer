//
//  PlayButtonView.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import SwiftUI

struct PlayButtonView: View {
    @ObservedObject var conductor: SequencerConductor
    let darkGray = Color(UIColor.darkGray)
    var body: some View {
        Image(systemName: conductor.data.isPlaying ? "play.fill" : "play")
            .resizable()
            .foregroundColor(darkGray)
            .frame(width: 32, height: 32)
            .onTapGesture {
                conductor.sequencer.playFromStart()
                conductor.data.isPlaying.toggle()
            }
    }
}


