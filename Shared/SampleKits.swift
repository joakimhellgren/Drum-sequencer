//
//  SampleKits.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import Foundation
import AudioKit

struct SampleKits {
    let kitOne: [Sample] = [
        Sample("kick", file: "Samples/bass_drum_C1.wav", note: 24),
        Sample("snare", file: "Samples/snare_D1.wav", note: 26),
        Sample("clap", file: "Samples/clap_D#1.wav", note: 27),
        Sample("low", file: "Samples/lo_tom_F1.wav", note: 29),
        Sample("closed", file: "Samples/closed_hi_hat_F#1.wav", note: 30),
        Sample("open", file: "Samples/open_hi_hat_A#1.wav", note: 34),
        Sample("mid", file: "Samples/mid_tom_B1.wav", note: 35),
        Sample("high", file: "Samples/hi_tom_D2.wav", note: 38)
    ]
}
