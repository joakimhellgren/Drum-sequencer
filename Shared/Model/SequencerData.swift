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
            Sample("1", file: "Samples/kit1/1_C1.wav", note: 24),
            Sample("2", file: "Samples/kit1/1_D1.wav", note: 26),
            Sample("3", file: "Samples/kit1/1_D#1.wav", note: 27),
            Sample("4", file: "Samples/kit1/1_F1.wav", note: 29),
            Sample("5", file: "Samples/kit1/1_F#1.wav", note: 30),
            Sample("6", file: "Samples/kit1/1_A#1.wav", note: 34),
            Sample("7", file: "Samples/kit1/1_B1.wav", note: 35),
            Sample("8", file: "Samples/kit1/1_D2.wav", note: 38)
        ],
        [
            Sample("1", file: "Samples/kit2/2_C1.wav", note: 24),
            Sample("2", file: "Samples/kit2/2_D1.wav", note: 26),
            Sample("3", file: "Samples/kit2/2_D#1.wav", note: 27),
            Sample("4", file: "Samples/kit2/2_F1.wav", note: 29),
            Sample("5", file: "Samples/kit2/2_F#1.wav", note: 30),
            Sample("6", file: "Samples/kit2/2_A#1.wav", note: 34),
            Sample("7", file: "Samples/kit2/2_B1.wav", note: 35),
            Sample("8", file: "Samples/kit2/2_D2.wav", note: 38)
        ],
        [
            Sample("1", file: "Samples/kit3/3_C1.wav", note: 24),
            Sample("2", file: "Samples/kit3/3_D1.wav", note: 26),
            Sample("3", file: "Samples/kit3/3_D#1.wav", note: 27),
            Sample("4", file: "Samples/kit3/3_F1.wav", note: 29),
            Sample("5", file: "Samples/kit3/3_F#1.wav", note: 30),
            Sample("6", file: "Samples/kit3/3_A#1.wav", note: 34),
            Sample("7", file: "Samples/kit3/3_B1.wav", note: 35),
            Sample("8", file: "Samples/kit3/3_D2.wav", note: 38)
        ],
        [
            Sample("1", file: "Samples/kit4/4_C1.wav", note: 24),
            Sample("2", file: "Samples/kit4/4_D1.wav", note: 26),
            Sample("3", file: "Samples/kit4/4_D#1.wav", note: 27),
            Sample("4", file: "Samples/kit4/4_F1.wav", note: 29),
            Sample("5", file: "Samples/kit4/4_F#1.wav", note: 30),
            Sample("6", file: "Samples/kit4/4_A#1.wav", note: 34),
            Sample("7", file: "Samples/kit4/4_B1.wav", note: 35),
            Sample("8", file: "Samples/kit4/4_D2.wav", note: 38)
        ],
        [
            Sample("1", file: "Samples/kit5/5_C1.wav", note: 24),
            Sample("2", file: "Samples/kit5/5_D1.wav", note: 26),
            Sample("3", file: "Samples/kit5/5_D#1.wav", note: 27),
            Sample("4", file: "Samples/kit5/5_F1.wav", note: 29),
            Sample("5", file: "Samples/kit5/5_F#1.wav", note: 30),
            Sample("6", file: "Samples/kit5/5_A#1.wav", note: 34),
            Sample("7", file: "Samples/kit5/5_B1.wav", note: 35),
            Sample("8", file: "Samples/kit5/5_D2.wav", note: 38)
        ],
        [
            Sample("1", file: "Samples/kit6/6_C1.wav", note: 24),
            Sample("2", file: "Samples/kit6/6_D1.wav", note: 26),
            Sample("3", file: "Samples/kit6/6_D#1.wav", note: 27),
            Sample("4", file: "Samples/kit6/6_F1.wav", note: 29),
            Sample("5", file: "Samples/kit6/6_F#1.wav", note: 30),
            Sample("6", file: "Samples/kit6/6_A#1.wav", note: 34),
            Sample("7", file: "Samples/kit6/6_B1.wav", note: 35),
            Sample("8", file: "Samples/kit6/6_D2.wav", note: 38)
        ],
        
        [
            Sample("1", file: "Samples/kit7/7_C1.wav", note: 24),
            Sample("2", file: "Samples/kit7/7_D1.wav", note: 26),
            Sample("3", file: "Samples/kit7/7_D#1.wav", note: 27),
            Sample("4", file: "Samples/kit7/7_F1.wav", note: 29),
            Sample("5", file: "Samples/kit7/7_F#1.wav", note: 30),
            Sample("6", file: "Samples/kit7/7_A#1.wav", note: 34),
            Sample("7", file: "Samples/kit7/7_B1.wav", note: 35),
            Sample("8", file: "Samples/kit7/7_D2.wav", note: 38)
        ],
        
        [
            Sample("1", file: "Samples/kit8/8_C1.wav", note: 24),
            Sample("2", file: "Samples/kit8/8_D1.wav", note: 26),
            Sample("3", file: "Samples/kit8/8_D#1.wav", note: 27),
            Sample("4", file: "Samples/kit8/8_F1.wav", note: 29),
            Sample("5", file: "Samples/kit8/8_F#1.wav", note: 30),
            Sample("6", file: "Samples/kit8/8_A#1.wav", note: 34),
            Sample("7", file: "Samples/kit8/8_B1.wav", note: 35),
            Sample("8", file: "Samples/kit8/8_D2.wav", note: 38)
        ],
    ]
    
}
