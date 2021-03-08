//
//  KorgLowPassFilterData.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-06.
//

import AVFoundation

struct KorgLowPassFilterData {
    var cutoffFrequency: AUValue = 2_000.0
    var resonance: AUValue = 0.15
    var saturation: AUValue = 0.0
    var rampDuration: AUValue = 0.02
    var balance: AUValue = 0.5
}
