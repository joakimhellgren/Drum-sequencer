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
    var balance: AUValue = 0.0
}

struct ClipperData {
    var limit: AUValue = 1.0
    var rampDuration: AUValue = 0.02
    var balance: AUValue = 0.0
}
