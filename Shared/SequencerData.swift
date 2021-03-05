//
//  SequencerData.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import Foundation
import AudioKit

struct SequencerData {
    var isPlaying = false
    var tempo: BPM = 480
    var metronomeSignature: Int = 16
    var trackSignature: [Int] = [16, 16, 16, 16, 16, 16, 16, 16]
    var notes: [Int] = [24, 26, 27, 29, 30, 34, 35, 38]
    var noteStatus: [[Bool]] = [[true], [false], [false], [false], [false], [false], [false], [false]]
    var currentBeat: [Int] = [0]
    var trackCount = 8
    var samples: [[Sample]] = [
        [
            Sample("1", file: "Samples/bass_drum_C1.wav", note: 24),
            Sample("2", file: "Samples/snare_D1.wav", note: 26),
            Sample("3", file: "Samples/clap_D#1.wav", note: 27),
            Sample("4", file: "Samples/lo_tom_F1.wav", note: 29),
            Sample("5", file: "Samples/closed_hi_hat_F#1.wav", note: 30),
            Sample("6", file: "Samples/open_hi_hat_A#1.wav", note: 34),
            Sample("7", file: "Samples/mid_tom_B1.wav", note: 35),
            Sample("8", file: "Samples/hi_tom_D2.wav", note: 38)
        ],
        [
            Sample("1", file: "Samples/bong_hi_hard_C1.wav", note: 24),
            Sample("2", file: "Samples/cong_low_ring_D1.wav", note: 26),
            Sample("3", file: "Samples/cong_low_slap_D#1.wav", note: 27),
            Sample("4", file: "Samples/bong_lo_soft_F1.wav", note: 29),
            Sample("5", file: "Samples/bong_hi_soft_F#1.wav", note: 30),
            Sample("6", file: "Samples/cong_hi_slap_A#1.wav", note: 34),
            Sample("7", file: "Samples/cong_hi_mute_B1.wav", note: 35),
            Sample("8", file: "Samples/bong_lo_hard_D2.wav", note: 38)
        ],
        [
            Sample("1", file: "Samples/vibra_C1.wav", note: 24),
            Sample("2", file: "Samples/vibra_D1.wav", note: 26),
            Sample("3", file: "Samples/vibra_D#1.wav", note: 27),
            Sample("4", file: "Samples/vibra_F1.wav", note: 29),
            Sample("5", file: "Samples/vibra_F#1.wav", note: 30),
            Sample("6", file: "Samples/vibra_A#1.wav", note: 34),
            Sample("7", file: "Samples/vibra_B1.wav", note: 35),
            Sample("8", file: "Samples/vibra_D2.wav", note: 38)
        ]
    ]
    
}
