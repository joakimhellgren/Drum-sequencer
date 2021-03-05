//
//  Sample.swift
//  Euclidean Sequencer
//
//  Created by Joakim Hellgren on 2021-03-04.
//

import AVFoundation
import SwiftUI
import AudioKit


struct Sample {
    var name: String
    var fileName: String
    var midiNote: Int
    var audioFile: AVAudioFile?
    var color = UIColor.secondarySystemBackground

    
    init (_ sampleName: String, file: String, note: Int) {
        name = sampleName
        fileName = file
        midiNote = note
        
        guard let url = Bundle.main.resourceURL?.appendingPathComponent(file) else { return }
        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            Log("Could not load: $fileName")
        }
    }
}
