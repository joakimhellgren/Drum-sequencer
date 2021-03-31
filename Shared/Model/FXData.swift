//
//  VariableDelayData.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-06.
//

import AVFoundation

struct VariableDelayData {
    var time: AUValue = 0
    var feedback: AUValue = 0
    var rampDuration: AUValue = 0.02
    var balance: AUValue = 0.0
}

struct CostelloReverbData {
    var feedback: AUValue = 0.6
    var cutoffFrequency: AUValue = 4_000.0
    var rampDuration: AUValue = 0.02
    var balance: AUValue = 0.3
}

struct ClipperData {
    var limit: AUValue = 1.0
    var rampDuration: AUValue = 0.02
    var balance: AUValue = 0.0
}

struct KorgLowPassFilterData {
    var cutoffFrequency: AUValue = 2_000.0
    var resonance: AUValue = 0.15
    var saturation: AUValue = 0.0
    var rampDuration: AUValue = 0.02
    var balance: AUValue = 0.0
}
